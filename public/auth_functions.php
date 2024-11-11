<?php

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Routing\RouteCollectorProxy;

$app->group('/auth', function (RouteCollectorProxy $group) {
    $group->map(['POST', 'GET', 'DELETE', 'PATCH', 'PUT'], '', function ($request, $response, array $args) {
        // Find, delete, patch or replace user identified by $args['id']
        // ...
        
        return $response;
    })->setName('authentication');

    // users api's collection
    $group->group('/u', function (RouteCollectorProxy $group) {
        // Route for accessing dashboard experiences
        $group->map(['POST', 'GET', 'DELETE', 'PATCH', 'PUT'], '/{id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Find, delete, patch or replace user identified by $args['id']
            // ...
            return $response;
        })->setName('users-authentication');

        // user login
        $group->post('/login', function (Request $request, Response $response, array $args) {
            // Route: /auth/u/login

            try
            {
                $allPostVars = json_decode($request->getBody(), true);
                $userName = $allPostVars["a"] ?? null;
                $passWord = $allPostVars["b"] ?? null;
                $mode = $allPostVars["c"] ?? null; // either phone or email

                if ($userName && $passWord && $mode) {
                    
                    $db = getPgDB();

                    // fetch user
                    if ($mode == "p") {
                        $qry = $db->prepare("SELECT u.app_user_id AS user_id, p.user_name, p.email, p.phone, p.last_gps_location, u.pwd
                                            FROM users.app_user_profile p
                                            INNER JOIN users.app_users u USING (app_user_id)
                                            WHERE u.active IS TRUE
                                            AND p.phone = :phone");
                        $qry->execute( [ ':phone' => $userName ] );
                    }

                    if ($mode == "e") {
                        $qry = $db->prepare("SELECT u.app_user_id AS user_id, p.user_name, p.email, p.phone, p.last_gps_location, u.pwd
                                            FROM users.app_user_profile p
                                            INNER JOIN users.app_users u USING (app_user_id)
                                            WHERE u.active IS TRUE
                                            AND p.email = :email");
                        $qry->execute( [ ':email' => $userName ] );
                    }
                    
                    $fetchedUser = $qry->fetch(PDO::FETCH_OBJ);
                    unset($qry);

                    if (isset($fetchedUser)) {
                        $passwordHash = str_replace( '\/', '/', $fetchedUser->pwd );

                        $passHash = str_replace( '\/', '/', $passwordHash );
                        if ($passHash === false || !password_verify($passWord, $passHash)) {
                            // incorrect password
                            $payload = json_encode( ['response' => 'error', 'code' => 3, 'message' => 'Wrong credentials'] );
                            $response->getBody()->write($payload);
                            return $response->withHeader('Content-Type', 'application/json')
                                            ->withHeader('Content-Length', strlen($payload))
                                            ->withStatus(401);
                        } else {
                            $user = new stdClass();
                            $user->user_id = $fetchedUser->user_id;
                            $user->user_name = $fetchedUser->user_name;
                            $user->email = $fetchedUser->email;
                            $user->phone = $fetchedUser->phone;
                            $user->last_gps_location = $fetchedUser->last_gps_location;

                            $payload =   json_encode( [ 'response' => 'success', 'data' => $user ] );
                            unset($db,$fetchedUser,$user);
                        
                            $response->getBody()->write($payload);
                            return $response->withHeader('Content-Type', 'application/json')
                                            ->withHeader('Content-Length', strlen($payload))
                                            ->withStatus(200);
                        }
                    } else {
                        $payload = json_encode( ['response' => 'error', 'code' => 2, 'message' => 'Wrong credentials'] );
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')
                                        ->withHeader('Content-Length', strlen($payload))
                                        ->withStatus(401);
                    }

                } else {
                    // missing required parameters
                    $payload = json_encode( ['response' => 'error', 'code' => 1, 'message' => 'Unable to log in'] );
                    $response->getBody()->write($payload);
                    return $response->withHeader('Content-Type', 'application/json')
                                    ->withHeader('Content-Length', strlen($payload))
                                    ->withStatus(401);
                }
                
            } catch(PDOException $e) {
                $payload = json_encode( ['response' => 'error', 'code' => 0, 'message' => $e->getMessage()] );
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')
                                ->withHeader('Content-Length', strlen($payload))
                                ->withStatus(401);
            }
            
        })->setName('user-login');

        // list tickets
        $group->get('/list-paid-tickets/{user_id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Route: /experiences/dashboard/list-paid-tickets/{user_id}

            $userId = $args['user_id'];
            
            try
            {

                if ($userId == null || $userId == 0) {
                    $payload =   json_encode(array('response' => 'error', 'message' => 'No data' ));
                    $response->getBody()->write($payload);
                    return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                } else {
                    $db = getPgDB();

                    // PROFILE
                    $qry = $db->prepare('SELECT u.user_id, u.name, u.email, up.tenant_id, up.first_name, up.last_name, up.phone,
                                                up.is_staff, up.is_super_user, up.is_active
                                            FROM kb.users u
                                            INNER JOIN kb.user_profile up USING (user_id)
                                            WHERE up.is_active IS TRUE AND up.user_id = :userId');
                    $qry->execute( array( ':userId' => $userId ) );
                    $profile = $qry->fetch(PDO::FETCH_OBJ);
                    unset($qry1);

                    if ($profile) {
                        // STAFF OR ADMIN
                        if ( $profile->is_staff == true || $profile->is_super_user == true ) {
                            // experiences
                            $sth = $db->prepare("SELECT d.experience_ticket_id, xt.name, xt.phone, xt.email, ticket_number, xt.venue_id,
                                                    l.name AS venue_name, dpo_trans_id, mpesa_ref, xt.created_on, d.ticket_details
                                                FROM kb.experience_tickets xt
                                                INNER JOIN (
                                                    SELECT experience_ticket_id, array_to_json(array_agg(row_to_json(c))) AS ticket_details
                                                    FROM (
                                                        SELECT xd.experience_ticket_detail_id, xd.experience_ticket_id, xd.experience_id, xd.experience_name,
                                                            xd.attendance_date AS ticket_date, xd.attendance_time AS ticket_time, xd.cost AS experience_cost,
                                                            xd.extras_exist, xd.extras_cost, xd.attendees, xd.indemnitors, addons
                                                        FROM kb.experience_tickets_details xd
                                                        INNER JOIN (
                                                            SELECT xd1.experience_ticket_detail_id, array_to_json(array_agg(row_to_json(a))) AS addons
                                                            FROM kb.experience_tickets_details xd1
                                                            LEFT JOIN (
                                                                SELECT xx.experience_ticket_detail_id, extra_name AS addon, selected_qty AS qty, cost AS total
                                                                FROM kb.experience_tickets_details_extras xx
                                                                ORDER BY experience_tickets_details_extra_id DESC
                                                            )a USING (experience_ticket_detail_id)
                                                            GROUP BY experience_ticket_detail_id
                                                            ORDER BY experience_ticket_detail_id DESC
                                                        )b USING (experience_ticket_detail_id)
                                                        WHERE xd.attendance_date::date >= NOW() - INTERVAL '7 days'
                                                        ORDER BY experience_ticket_id DESC, experience_id DESC
                                                    )c
                                                    GROUP BY experience_ticket_id
                                                    ORDER BY experience_ticket_id DESC
                                                )d USING (experience_ticket_id)
                                                INNER JOIN kb.locations l ON xt.venue_id = l.location_id
                                                WHERE xt.status IS TRUE
                                                ORDER BY experience_ticket_id DESC");
                            $sth->execute( array() );
                            $tickets = $sth->fetchAll(PDO::FETCH_OBJ);
                            unset($sth);

                            if ($tickets && is_array($tickets)) {
                                for ($i = 0; $i < count($tickets); $i++) {
                                    $tickets[$i]->ticket_details = json_decode($tickets[$i]->ticket_details);
                                    if (is_array($tickets[$i]->ticket_details)) {
                                        for ($j = 0; $j < count($tickets[$i]->ticket_details); $j++) {
                                            $tickets[$i]->ticket_details[$j]->indemnitors = json_decode($tickets[$i]->ticket_details[$j]->indemnitors);
                                        }
                                    }
                                }
                            }

                            $payload = json_encode(array('response' => 'success', 'data' => $tickets ));
                            $response->getBody()->write($payload);

                            unset($db,$tickets);
                            return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                        }
                        
                        // TENANTS
                        if ($profile->is_staff == false && $profile->is_super_user == false && $profile->tenant_id != null) {
                            // code 

                            $payload = json_encode(array('response' => 'success', 'data' => null ));
                            $response->getBody()->write($payload);

                            unset($db,$tickets);
                            return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                        }
                    } else {
                        $payload =   json_encode(array('response' => 'error', 'message' => 'No data' ));
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                    }
                }
                
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('dashboard-list-experiences-tickets');

        // list orders
        $group->get('/list-unpaid-tickets/{user_id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Route: /experiences/dashboard/list-unpaid-tickets/{user_id}

            $userId = $args['user_id'];
            
            try
            {

                if ($userId == null || $userId == 0) {
                    $payload =   json_encode(array('response' => 'error', 'message' => 'No data' ));
                    $response->getBody()->write($payload);
                    return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                } else {
                    $db = getPgDB();

                    // PROFILE
                    $qry = $db->prepare('SELECT u.user_id, u.name, u.email, up.tenant_id, up.first_name, up.last_name, up.phone,
                                                up.is_staff, up.is_super_user, up.is_active
                                            FROM kb.users u
                                            INNER JOIN kb.user_profile up USING (user_id)
                                            WHERE up.is_active IS TRUE AND up.user_id = :userId');
                    $qry->execute( array( ':userId' => $userId ) );
                    $profile = $qry->fetch(PDO::FETCH_OBJ);
                    unset($qry1);

                    if ($profile) {
                        // STAFF OR ADMIN
                        if ( $profile->is_staff == true || $profile->is_super_user == true ) {
                            // experiences
                            $sth = $db->prepare("SELECT d.experience_ticket_id, xt.name, xt.phone, xt.email, ticket_number, xt.venue_id,
                                                    l.name AS venue_name, dpo_trans_id, mpesa_ref, xt.created_on, d.ticket_details
                                                FROM kb.experience_tickets xt
                                                INNER JOIN (
                                                    SELECT experience_ticket_id, array_to_json(array_agg(row_to_json(c))) AS ticket_details
                                                    FROM (
                                                        SELECT xd.experience_ticket_detail_id, xd.experience_ticket_id, xd.experience_id, xd.experience_name,
                                                            xd.attendance_date AS ticket_date, xd.attendance_time AS ticket_time, xd.cost AS experience_cost,
                                                            xd.extras_exist, xd.extras_cost, xd.attendees, xd.indemnitors, addons
                                                        FROM kb.experience_tickets_details xd
                                                        INNER JOIN (
                                                            SELECT xd1.experience_ticket_detail_id, array_to_json(array_agg(row_to_json(a))) AS addons
                                                            FROM kb.experience_tickets_details xd1
                                                            LEFT JOIN (
                                                                SELECT xx.experience_ticket_detail_id, extra_name AS addon, selected_qty AS qty, cost AS total
                                                                FROM kb.experience_tickets_details_extras xx
                                                                ORDER BY experience_tickets_details_extra_id DESC
                                                            )a USING (experience_ticket_detail_id)
                                                            GROUP BY experience_ticket_detail_id
                                                            ORDER BY experience_ticket_detail_id DESC
                                                        )b USING (experience_ticket_detail_id)
                                                        WHERE xd.attendance_date::date >= NOW() - INTERVAL '7 days'
                                                        ORDER BY experience_ticket_id DESC, experience_id DESC
                                                    )c
                                                    GROUP BY experience_ticket_id
                                                    ORDER BY experience_ticket_id DESC
                                                )d USING (experience_ticket_id)
                                                INNER JOIN kb.locations l ON xt.venue_id = l.location_id
                                                WHERE xt.status IS FALSE
                                                ORDER BY experience_ticket_id DESC");
                            $sth->execute( array() );
                            $orders = $sth->fetchAll(PDO::FETCH_OBJ);
                            unset($sth);

                            if ($orders && is_array($orders)) {
                                for ($i = 0; $i < count($orders); $i++) {
                                    $orders[$i]->ticket_details = json_decode($orders[$i]->ticket_details);
                                }
                            }

                            $payload = json_encode(array('response' => 'success', 'data' => $orders ));
                            $response->getBody()->write($payload);

                            unset($db,$orders);
                            return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                        }
                        
                        // TENANTS
                        if ($profile->is_staff == false && $profile->is_super_user == false && $profile->tenant_id != null) {
                            // code 

                            $payload = json_encode(array('response' => 'success', 'data' => null ));
                            $response->getBody()->write($payload);

                            unset($db,$tickets);
                            return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                        }
                    } else {
                        $payload =   json_encode(array('response' => 'error', 'message' => 'No data' ));
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                    }
                }
                
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('dashboard-list-experiences-orders');
    });

    // staff api's collection
    $group->group('/s', function (RouteCollectorProxy $group) {
        // Route for accessing front end experiences
        $group->map(['POST', 'GET', 'DELETE', 'PATCH', 'PUT'], '/{id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Find, delete, patch or replace user identified by $args['id']
            // ...
            return $response;
        })->setName('front-end-experiences');

        // list experiences slider items
        $group->get('/list-slider', function (Request $request, Response $response, array $args) {
            // Route: /experiences/journey/list-slider
            
            try
            {
                $db = getPgDB();
                $sth = $db->prepare("SELECT * FROM (
                                        (
                                            SELECT l.name AS slider_text, l.image AS slider_image, l.slug, 'venue' AS category
                                            FROM kb.locations l
                                            WHERE l.experiences_slider IS TRUE
                                            ORDER BY updated_at DESC LIMIT 6
                                        )
                                        UNION
                                        (
                                            SELECT x.name AS slider_text, x.image AS slider_image, l.slug, 'experience' AS category
                                            FROM kb.experiences x
                                            INNER JOIN kb.locations l ON x.venue_id = l.location_id
                                            WHERE x.is_featured IS TRUE
                                            ORDER BY x.updated_on DESC LIMIT 6
                                        )
                                    )a");
                $sth->execute( array() );
                $sliderItems = $sth->fetchAll(PDO::FETCH_OBJ);

                $payload =   json_encode(array('response' => 'success', 'data' => $sliderItems ));
                unset($db,$sth,$sliderItems);

                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('list-experiences-slider');

        // list experiences
        $group->get('/list-venue-experiences/{slug}', function (Request $request, Response $response, array $args) {
            // Route: /experiences/journey/list-venue-experiences/{slug}

            $locationSlug = $args['slug'];

            $experienceListingDetails = new stdClass();
            $experienceListingDetails->experiences = array();
            
            try
            {
                $db = getPgDB();
                $venue_id = null;

                // VENUE DETAILS
                $sth1 = $db->prepare("SELECT l.location_id, l.name AS location_name, l.phone AS location_phone, l.email AS location_email,
                                        l.address AS location_address, l.details AS location_description, l.town_id, t.town,
                                        l.image AS poster, other_image AS img_2, image3 AS img_3, image4 AS img_4, image5 AS img_5
                                    FROM kb.locations l
                                    LEFT JOIN public.towns t USING (town_id)
                                    WHERE l.slug = :locationSlug");
                $sth1->execute( array( ':locationSlug' => $locationSlug ) );
                $locationDetails = $sth1->fetch(PDO::FETCH_OBJ);
                $venue_id = (isset($locationDetails)) ? $locationDetails->location_id : null;
                $locationDetails->location_description = (isset($locationDetails) && isset($locationDetails->location_description)) ? strip_tags($locationDetails->location_description) : null;
                $experienceListingDetails->location = $locationDetails;
                unset($sth1,$locationDetails);

                // VENUE OPEN HOURS
                $sth_1 = $db->prepare("SELECT o.location_open_hour_id AS id, o.day_id, d.name, open_time, close_time 
                                        FROM kb.location_open_hours o
                                        INNER JOIN kb.days d USING (day_id)
                                        WHERE location_id = :locationId
                                        ORDER BY day_id ASC");
                $sth_1->execute( array( ':locationId' => $venue_id ) );
                $openHours = $sth_1->fetchAll(PDO::FETCH_OBJ);
                $experienceListingDetails->location->open_hours = ($openHours) ? $openHours : array();
                unset($sth_1,$openHours);

                // VENUE'S EXPERIENCES
                $sth2 = $db->prepare("SELECT e.experience_id, e.name, e.slug, e.image AS poster, l.name AS venue, e.description, 
                                        e.indemnity_form, e.town_id, t.town AS location
                                    FROM kb.experiences e
                                    INNER JOIN kb.locations l ON e.venue_id = l.location_id
                                    LEFT JOIN public.towns t ON e.town_id = t.town_id
                                    WHERE e.is_disabled IS FALSE
                                    AND e.venue_id = :venue_id
                                    ORDER BY e.name ASC");
                $sth2->execute( array( ':venue_id' => $venue_id ) );
                $experiences = $sth2->fetchAll(PDO::FETCH_OBJ);
                unset($sth2);

                if ($experiences && is_array($experiences)) {
                    // EACH EXPERIENCE'S DATA

                    for ($i=0; $i < count($experiences); $i++) { 
                        // TICKET TYPES
                        $qry3 = $db->prepare("SELECT xt.experience_ticket_type_id, xt.name, xt.price, xt.group_ticket, xt.group_quantity, xt.max_per_customer
                                                FROM kb.experience_ticket_types xt
                                                WHERE xt.experience_id = :experienceId
                                                ORDER BY xt.experience_ticket_type_id ASC");
                        $qry3->execute( array( ':experienceId' => $experiences[$i]->experience_id ) );
                        $ticket_types = $qry3->fetchAll(PDO::FETCH_OBJ);
                        $experiences[$i]->ticket_types = $ticket_types;
                        unset($qry3,$ticket_types);

                        // TIMESLOTS
                        $qry4 = $db->prepare("SELECT xo.open_hour_id, xo.day_id, d.name AS day, xo.open_time, xo.close_time,
                                                array_to_json(array_agg(row_to_json(xs))) AS time_slots
                                            FROM kb.experience_open_hours xo
                                            INNER JOIN kb.days d USING (day_id)
                                            LEFT JOIN (
                                                SELECT xs.timeslot_id, xs.open_hour_id, xs.start_time, xs.end_time, xs.use_time_interval AS use_interval, xs.time_interval, xs.max_people_per_slot 
                                                FROM kb.experience_timeslots xs
                                                WHERE xs.experience_id = :experienceId
                                                ORDER BY xs.open_hour_id ASC
                                            )xs USING (open_hour_id)
                                            WHERE xo.experience_id = :experienceId
                                            GROUP BY xo.open_hour_id, xo.day_id, d.name, xo.open_time, xo.close_time
                                            ORDER BY xo.day_id ASC, xo.open_time ASC");
                        $qry4->execute( array( ':experienceId' => $experiences[$i]->experience_id ) );
                        $timeslots = $qry4->fetchAll(PDO::FETCH_OBJ);
                        if ($timeslots) {
                            foreach ($timeslots as $key => $value) {
                                $timeslots[$key]->time_slots = json_decode($value->time_slots) ?? null;
                            }
                        }
                        $experiences[$i]->time_slots = $timeslots;
                        unset($qry4,$timeslots);

                        // ADDONS | CONCESSSIONS
                        $qry5 = $db->prepare("SELECT c.concession_id, c.name, c.unit_price AS price, c.icon, max_selectable, min_selectable 
                                            FROM kb.concessions c
                                            WHERE experience_id = :experienceId
                                            ORDER BY concession_id ASC");
                        $qry5->execute( array( ':experienceId' => $experiences[$i]->experience_id ) );
                        $addons = $qry5->fetchAll(PDO::FETCH_OBJ);
                        $experiences[$i]->addons = $addons;
                        unset($qry5,$addons);

                        array_push($experienceListingDetails->experiences, $experiences[$i]);
                    }
                }

                unset($db,$experiences);

                $payload =   json_encode(array('response' => 'success', 'data' => $experienceListingDetails ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('list-front-end-venue-experiences');

        // list experiences
        $group->get('/list-experiences', function (Request $request, Response $response, array $args) {
            // Route: /experiences/journey/list-experiences
            
            try
            {
                $db = getPgDB();
                $sth = $db->prepare("SELECT DISTINCT l.location_id AS id, l.name, l.address, l.slug, l.image AS poster,
                                        e.town_id, t.town
                                    FROM kb.experiences e
                                    INNER JOIN kb.locations l ON e.venue_id = l.location_id
                                    LEFT JOIN public.towns t ON e.town_id = t.town_id
                                    WHERE e.is_disabled IS FALSE AND e.is_private IS FALSE
                                    ORDER BY l.name ASC");
                $sth->execute( array() );
                $experiences = $sth->fetchAll(PDO::FETCH_OBJ);
                unset($sth);

                $sth2 = $db->prepare("SELECT DISTINCT ON(x.town_id, t.town)x.town_id, t.town 
                                    FROM towns t 
                                    INNER JOIN kb.experiences x USING (town_id)
                                    ORDER BY town ASC");
                $sth2->execute( array() );
                $towns = $sth2->fetchAll(PDO::FETCH_OBJ);
                unset($sth2);

                $payload =   json_encode(array('response' => 'success', 'data' => $experiences, 'locations' => $towns ));
                unset($db,$experiences,$towns);

                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('list-front-end-experiences');

        // order experience
        $group->post('/order', function (Request $request, Response $response, array $args) {
            // Route: /experiences/journey/order
    
            try
            {
                $allPostVars = json_decode($request->getBody(), true);
                $name = $allPostVars["name"] ?? null;
                $phone = $allPostVars["phone"] ?? null;
                $email = $allPostVars["email"] ?? null;
                $venue_id = $allPostVars["a"] ?? null;
                $experiences = $allPostVars["x"] ?? null; // array
                $indemnitors = $allPostVars["i"] ?? null; // array
                $mode = $allPostVars["mode"] ?? null;
                $experiences_names = "";
                $experience_location = "";
                $no_of_tickets = 0;
                $grandTotal = 0;

                $phone = formatPhoneNumber($phone);
    
                if ( $mode && $name && $phone && $email && $venue_id && is_array($experiences) ) {
                    try
                    {
                        /**
                         * FLOW:
                         * 1. Insert the main record to acquire the record's id
                         * 2. Calculate the totals for each experience & extras
                         * 3. Calculate the grand total
                         * 4. If the experience has an indemnity form, check for signed indemnitors
                         * 5. If the indemnitors are not signed, return error else proceed to payment
                         */

                        $db = getPgDB();

                        $uniquePhoneHash = hash('sha256', $phone);
		                $orderId = substr($uniquePhoneHash, -6) . strtoupper(generateOrderId(4));
                        $transactionToken = null; // For DPO: TransactionId, For Mpesa: RefereceCode

                        $sth0 = $db->prepare("SELECT name FROM kb.locations WHERE location_id = :venue_id;");
                        $sth0->execute( array(':venue_id' => $venue_id) );
                        $venueRes = $sth0->fetch(PDO::FETCH_OBJ);
                        $experience_location = $venueRes->name;
                        unset($sth0,$venueRes);

                        // 1.
                        $sth = $db->prepare("INSERT INTO kb.experience_tickets(order_id, name, phone, email, status, venue_id, email_sent, confirmation_email_sent, is_complimentary, created_on)
                                            VALUES (:orderId, :name, :phone, :email, FALSE, :venue_id, FALSE, FALSE, FALSE, NOW())
                                            RETURNING experience_ticket_id;");
                        $sth->execute( array( 
                            ':orderId' => $orderId,
                            ':name' => $name,
                            ':phone' => $phone, 
                            ':email' => $email, 
                            ':venue_id' => $venue_id 
                        ) );
                        $ticketRes = $sth->fetch(PDO::FETCH_OBJ);
                        $cutomer_ticket_id = $ticketRes->experience_ticket_id;
                        unset($sth);

                        foreach ($experiences as $experience) {
                            $experienceId = $experience["experience_id"] ?? null;
                            $attendanceDate = $experience["attendance_date"] ?? null;

                            if ($attendanceDate) {
                                $timestamp = strtotime($attendanceDate);
                                $attendanceDate = date("Y-m-d", $timestamp);
                            }

                            $attendanceTime = $experience["attendance_time"] ?? null;
                            $experienceName = $experience["experience_name"] ?? null;
                            $extrasExist = $experience["extras_exist"] ?? null;
                            $extras = $experience["extras"] ?? null; // array
                            $selectedTickets = $experience["selected_tickets"] ?? null; // array
                            $attendees = generateAttendeesString(json_encode($selectedTickets));
                            $selectedTicketsJson = json_encode($selectedTickets);
                            $experienceCost = 0;

                            if ( is_array($selectedTickets) && count($selectedTickets) > 0) {
                                $experiences_names .= $experienceName . " |";

                                // 2.
                                for ($i=0; $i < count($selectedTickets); $i++) { 
                                    $experienceTicketTypeId = $selectedTickets[$i]["ticket_type_id"] ?? null;
                                    $experienceTicketName = $selectedTickets[$i]["name"] ?? null;
                                    $experienceTicketQuantity = $selectedTickets[$i]["qty"] ?? null;

                                    $no_of_tickets += (int)$experienceTicketQuantity ?? 0;

                                    // fetch the price from the db & compute the cost
                                    $qry = $db->prepare("SELECT price FROM kb.experience_ticket_types WHERE experience_ticket_type_id = :experienceTicketTypeId");
                                    $qry->execute( array(':experienceTicketTypeId' => $experienceTicketTypeId ) );
                                    $priceResp = $qry->fetch(PDO::FETCH_OBJ);
                                    unset($qry);
                                    
                                    $price = $priceResp->price;
                                    $experienceCost += ($price * (int)$experienceTicketQuantity);

                                    // 3.
                                    $grandTotal += $experienceCost;
                                }

                                $sth2 = $db->prepare("INSERT INTO kb.experience_tickets_details(experience_ticket_id, experience_id, experience_name, attendance_date, attendance_time, cost, extras_exist, created_on, indemnitors, attendees, selected_tix_types)
                                                    VALUES (:cutomerTicketId, :experienceId, :experienceName, :attendanceDate, :attendanceTime, :cost, :extrasExist, NOW(), :indemnitors, :attendees, :selectedTicketsJson)
                                                    RETURNING experience_ticket_detail_id;");
                                $sth2->execute( array( 
                                    ':cutomerTicketId' => $cutomer_ticket_id,
                                    ':experienceId' => $experienceId, 
                                    ':experienceName' => $experienceName,
                                    ':attendanceDate' => $attendanceDate, 
                                    ':attendanceTime' => $attendanceTime, 
                                    ':cost' => $experienceCost, 
                                    ':extrasExist' => $extrasExist == true ? 'TRUE' : 'FALSE',
                                    ':indemnitors' => json_encode($indemnitors),
                                    ':attendees' => $attendees,
                                    ':selectedTicketsJson' => $selectedTicketsJson
                                ) );
                                $expTicketDetailRes = $sth2->fetch(PDO::FETCH_OBJ);
                                $experience_ticket_detail_id = $expTicketDetailRes->experience_ticket_detail_id;
                                unset($sth2);

                                if ($extrasExist) {
                                    foreach ($extras as $xtra) {
                                        // use the id to get the price for the "extra"
                                        $addon_id = $xtra['addon_id'] ?? null;
                                        $addon_name = $xtra['name'] ?? null;
                                        $addon_qty = $xtra['qty'] ?? null;
                                        
                                        $qry2 = $db->prepare("SELECT unit_price FROM kb.concessions WHERE concession_id = :addon_id");
                                        $qry2->execute( array(':addon_id' => $addon_id ) );
                                        $xtraResp = $qry2->fetch(PDO::FETCH_OBJ);
                                        unset($qry2);

                                        $addon_cost = $xtraResp->unit_price * (int)$addon_qty;

                                        // 3.
                                        $grandTotal += $addon_cost;

                                        $sth3 = $db->prepare("INSERT INTO kb.experience_tickets_details_extras(experience_ticket_detail_id, extra_name, selected_qty, cost)
                                                            VALUES (:experience_ticket_detail_id, :addon_name, :addon_qty, :addon_cost);");
                                        $sth3->execute( array( 
                                            ':experience_ticket_detail_id' => $experience_ticket_detail_id,
                                            ':addon_name' => $addon_name, 
                                            ':addon_qty' => $addon_qty,
                                            ':addon_cost' => $addon_cost, 
                                        ) );
                                        unset($sth3);

                                        $sth4 = $db->prepare("UPDATE kb.experience_tickets_details SET extras_cost = :addon_cost WHERE experience_ticket_detail_id = :experience_ticket_detail_id;");
                                        $sth4->execute( array( 
                                            ':addon_cost' => $addon_cost, 
                                            ':experience_ticket_detail_id' => $experience_ticket_detail_id
                                        ) );
                                        unset($sth4);
                                    }
                                }
                            }
                        }

                        // 5.
                        if ($mode == 'kb_mpesa') {
                            // initiate an mpesa transaction
                            $payload = new stdClass();
                            $payload->full_name = $name;
                            $payload->email = $email;
                            $payload->phone = formatPhoneNumber($phone);
                            $payload->amount = $grandTotal;
                            
                            $payload->reference = generateAccountNumber("EXPERIENCE", $cutomer_ticket_id);
                            $mpesaReference = $payload->reference;

                            $payload->description = strlen($experiences_names) > 40 ? substr($experiences_names, 0, 40) . '...' : $experiences_names;

                            $data = json_encode($payload);

                            // update the ticket with the token
                            $sth4 = $db->prepare("UPDATE kb.experience_tickets SET mpesa_ref = :mpesaReference, total_cost = :grandTotal WHERE experience_ticket_id = :cutomer_ticket_id;");
                            $sth4->execute( array( 
                                ':cutomer_ticket_id' => $cutomer_ticket_id,
                                ':mpesaReference' => $mpesaReference,
                                ':grandTotal' => $grandTotal
                            ) );
                            unset($sth4);

                            $url = 'https://api-lb.kenyabuzz.com/mpesaExpress';
                            $curl = curl_init($url);
                            curl_setopt($curl, CURLOPT_POST, true);
                            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
                            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
                            $mpesaTxnResp = curl_exec($curl);
                            curl_close($curl);

                            $mpesaResp = json_decode($mpesaTxnResp);
                    
                            $payload = json_encode(array('response' => 'success', 'data' => 'Order placed successfully', 'amount' => $grandTotal, 'token' => $mpesaReference, 'order' => $cutomer_ticket_id, 'status' => $mpesaResp));
                            unset($mpesaResp);
                            $response->getBody()->write($payload);
                            return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                        }

                        if ($mode == 'dpo') {
                            $usr = new stdClass();
                            $name_arr = explode(" ", $name);

                            $usr->first_name = $name_arr[0];
                            $usr->last_name = (count($name_arr) > 1 ? $name_arr[1] : $name_arr[0]);
                            $usr->email = $email;

                            $tkt = new stdClass();
                            $tkt->order_id = $orderId;
                            $tkt->experience_name = strlen($experiences_names) > 25 ? substr($experiences_names, 0, 25) . '...' : $experiences_names;
                            $tkt->venue = $experience_location;
                            $tkt->no_of_tickets = $no_of_tickets;
                            $tkt->cost = $grandTotal;
                            $tkt->concessions_cost = 0; // not really necessary since we already have the grand total
                            $tkt->phone = $phone;

                            $tokenResult = dpoCreateToken($usr,$tkt,"experience");
                            $tokenXml = new SimpleXMLElement($tokenResult);
                            // $transToken  = $tokenXml->TransToken;

                            $tkn = json_encode($tokenXml->TransToken);
                            $tknDecoded = json_decode($tkn);
                            $theActualToken = $tknDecoded->{0};

                            $rf = json_encode($tokenXml->TransRef);
                            $rfDecoded = json_decode($rf);
                            $theActualRef = $rfDecoded->{0};

                            // update the ticket with the token
                            $sth4 = $db->prepare("UPDATE kb.experience_tickets SET dpo_trans_id = :theActualToken, dpo_trans_ref = :theActualRef, total_cost = :grandTotal 
                                                WHERE experience_ticket_id = :cutomer_ticket_id;");
                            $sth4->execute( array( 
                                ':cutomer_ticket_id' => $cutomer_ticket_id,
                                ':theActualToken' => $theActualToken,
                                ':theActualRef' => $theActualRef,
                                ':grandTotal' => $grandTotal
                            ) );
                            unset($sth4);

                            $payload = json_encode(array('response' => 'success', 'data' => 'Order placed successfully', 'token' => $theActualToken));
                            $response->getBody()->write($payload);
                            return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                        }
    
                    } catch(PDOException $e1) {
                        $payload = json_encode(array('response' => 'error', 'code' => 3, 'message' => $e1->getMessage()));
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                    }
                } else {
                    $payload = json_encode(array('response' => 'error', 'code' => 2, 'message' => 'Unable to place order'));
                    $response->getBody()->write($payload);
                    return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                }
                
                unset($allPostVars);
            } catch(PDOException $e) {
                $payload = json_encode(array('response' => 'error', 'code' => 1, 'message' => $e->getMessage()));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }
            
        })->setName('order-experience');
    });
});
