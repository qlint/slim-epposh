<?php

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Routing\RouteCollectorProxy;

$app->group('/stores', function (RouteCollectorProxy $group) {
    $group->map(['POST', 'GET', 'DELETE', 'PATCH', 'PUT'], '', function ($request, $response, array $args) {
        // Find, delete, patch or replace user identified by $args['id']
        // ...
        
        return $response;
    })->setName('stores-endpoints');

    $group->group('/portal', function (RouteCollectorProxy $group) {
        // Route for accessing dashboard experiences
        $group->map(['POST', 'GET', 'DELETE', 'PATCH', 'PUT'], '/{id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Find, delete, patch or replace user identified by $args['id']
            // ...
            return $response;
        })->setName('dashboard-experiences');

        // list experiences
        $group->get('/list-experiences/{user_id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Route: /experiences/dashboard/list-experiences/{user_id}

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
                        $experiences = null;

                        // STAFF OR ADMIN
                        if ( $profile->is_staff == true || $profile->is_super_user == true ) {
                            // experiences
                            $sth = $db->prepare("SELECT experience_id, e.name, e.slug, l.name AS venue, t.town, is_disabled, is_private
                                                FROM kb.experiences e
                                                LEFT JOIN kb.locations l ON e.venue_id = l.location_id
                                                LEFT JOIN public.towns t ON e.town_id = t.town_id
                                                ORDER BY experience_id DESC
                                                LIMIT 200");
                            $sth->execute( array() );
                            $experiences = $sth->fetchAll(PDO::FETCH_OBJ);
                            unset($sth);
                        }
                        
                        // TENANTS
                        if ($profile->is_staff == false && $profile->is_super_user == false && $profile->tenant_id != null) {
                            // experiences
                            $sth = $db->prepare("SELECT experience_id, e.name, e.slug, l.name AS venue, t.town, is_disabled, is_private
                                                FROM kb.experiences e
                                                LEFT JOIN kb.locations l ON e.venue_id = l.location_id
                                                LEFT JOIN public.towns t ON e.town_id = t.town_id
                                                WHERE e.tenant_id = :tenantId
                                                ORDER BY experience_id DESC
                                                LIMIT 200");
                            $sth->execute( array(':tenantId' => $profile->tenant_id) );
                            $experiences = $sth->fetchAll(PDO::FETCH_OBJ);
                            unset($sth);
                        }

                        $payload =   json_encode(array('response' => 'success', 'data' => $experiences ));
                        $response->getBody()->write($payload);

                        unset($db,$experiences,$profile);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
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

        })->setName('dashboard-list-experiences');

        // view experience
        $group->get('/view-experience/{experience_id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Route: /experiences/dashboard/view-experience/{experience_id}

            $experienceId = $args['experience_id'];
            
            try
            {

                if ($experienceId == null || $experienceId == 0) {
                    $payload =   json_encode(array('response' => 'error', 'message' => 'No data' ));
                    $response->getBody()->write($payload);
                    return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                } else {
                    $db = getPgDB();

                    // EXPERIENCE DETAILS
                    $qry = $db->prepare("SELECT x.experience_id, x.name, x.slug, x.description, x.image, x.venue_id, l.name AS venue_name,
                                            x.country_id, c.country, x.town_id, t.town, x.category_id, indemnity_form, x.is_disabled, x.is_private,
                                            x.is_featured, x.tenant_id
                                        FROM kb.experiences x
                                        LEFT JOIN kb.locations l ON x.venue_id = l.location_id
                                        LEFT JOIN public.countries c ON x.country_id = c.country_id
                                        LEFT JOIN public.towns t ON x.town_id = t.town_id
                                        WHERE x.experience_id = :experienceId");
                    $qry->execute( array( ':experienceId' => $experienceId ) );
                    $details = $qry->fetch(PDO::FETCH_OBJ);
                    unset($qry);

                    if ($details) {
                        $results = new stdClass();

                        $results->details = $details;

                        // TICKET TYPES
                        $qry2 = $db->prepare("SELECT xt.experience_ticket_type_id, xt.name, xt.price, xt.group_ticket, xt.group_quantity, xt.max_per_customer
                                                FROM kb.experience_ticket_types xt
                                                WHERE xt.experience_id = :experienceId
                                                ORDER BY xt.experience_ticket_type_id ASC");
                        $qry2->execute( array( ':experienceId' => $experienceId ) );
                        $ticket_types = $qry2->fetchAll(PDO::FETCH_OBJ);
                        $results->ticket_types = $ticket_types;
                        unset($qry2,$ticket_types);
                        
                        // TIMESLOTS
                        $qry3 = $db->prepare("SELECT xo.open_hour_id, xo.day_id, d.name AS day, xo.open_time, xo.close_time,
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
                        $qry3->execute( array( ':experienceId' => $experienceId ) );
                        $timeslots = $qry3->fetchAll(PDO::FETCH_OBJ);
                        if ($timeslots) {
                            foreach ($timeslots as $key => $value) {
                                $timeslots[$key]->time_slots = json_decode($value->time_slots) ?? null;
                            }
                        }
                        $results->time_slots = $timeslots;
                        unset($qry3,$timeslots);

                        // ADDONS / CONCESSIONS
                        $qry4 = $db->prepare("SELECT c.concession_id, c.name, c.unit_price AS price, c.icon AS image, max_selectable, min_selectable 
                                            FROM kb.concessions c
                                            WHERE experience_id = :experienceId
                                            ORDER BY concession_id ASC");
                        $qry4->execute( array( ':experienceId' => $experienceId ) );
                        $addons = $qry4->fetchAll(PDO::FETCH_OBJ);
                        $results->addons = $addons;
                        unset($qry4,$addons);

                        $payload =   json_encode(array('response' => 'success', 'data' => $results ));
                        unset($db,$results);

                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                    } else {
                        $payload =   json_encode(array('response' => 'error', 'message' => 'No data' ));
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                    }
                    
                }
                
            } catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('dashboard-view-experience');

        // create-update an experience
        $group->post('/update-experience', function (Request $request, Response $response, array $args) {
            // Route: /experiences/dashboard/update-experience

            try
            {
                $allPostVars = json_decode($request->getBody(), true);
                $userId = $allPostVars["a"] ?? null;
                $data = $allPostVars["x"] ?? null;

                $addons = $data["addons"] ?? null; // array
                $categoryIds = $data["category_id"] ?? null; // array
                $countryId = $data["country_id"] ?? null;
                $description = $data["description"] ?? null;
                $experienceId = $data["experience_id"] ?? null;
                $image = $data["image"] ?? null;
                $indemnityForm = $data["indemnity_form"] ?? null;
                $isDisabled = $data["is_disabled"] ?? null;
                $isPrivate = $data["is_private"] ?? null;
                $isFeatured = $data["is_featured"] ?? null;
                $experienceName = $data["name"] ?? null;
                $openHours = $data["open_hours"] ?? null; // array
                $tenantId = $data["tenant_id"] ?? null;
                $ticketTypes = $data["ticket_types"] ?? null; // array
                $townId = $data["town_id"] ?? null;
                $venueId = $data["venue_id"] ?? null;

                // slug
                $str = strtolower($experienceName); // Convert to lowercase
                $str = preg_replace("/[^a-z0-9_\s]/", "-", $str); // Remove special characters
                $str = str_replace(" ", "-", $str); // Replace spaces with hyphen
                $slug = trim($str, "-"); // Trim hyphens from the start and end
                unset($str);
                
                $isUpdate = isset($experienceId) ? true : false;
                $categoryIdValues = null;

                if ( isset($categoryIds) ) {
                    $categoryIdValues = '{' . implode(',', $categoryIds) . '}';
                }

                $db = getPgDB();

                // 1. EXPERIENCE
                if ($isUpdate == true) {
                    // update

                    $sth = $db->prepare("UPDATE kb.experiences SET name = :experienceName, description = :description, 
                                            venue_id = :venueId, image = :image, category_id = :categoryIdValues, town_id = :townId, 
                                            indemnity_form = :indemnityForm, is_disabled = :isDisabled, is_private = :isPrivate, 
                                            updated_by = :userId, updated_on = CURRENT_TIMESTAMP, tenant_id = :tenantId, country_id = :countryId,
                                            is_featured = :isFeatured
                                        WHERE experience_id = :experienceId;");
                    $sth->execute( array(
                        ':experienceName' => $experienceName,
                        ':description' => $description,
                        ':venueId' => $venueId,
                        ':image' => $image,
                        ':categoryIdValues' => $categoryIdValues,
                        ':townId' => $townId,
                        ':indemnityForm' => $indemnityForm,
                        ':isDisabled' => ($isDisabled == true ? 'TRUE' : 'FALSE'),
                        ':isPrivate' => ($isPrivate == true ? 'TRUE' : 'FALSE'),
                        ':userId' => $userId,
                        ':tenantId' => $tenantId,
                        ':countryId' => $countryId,
                        ':isFeatured' => ($isFeatured == true ? 'TRUE' : 'FALSE'),
                        ':experienceId' => $experienceId
                    ) );
                    unset($sth);
                } else {
                    // insert

                    $sth = $db->prepare("INSERT INTO kb.experiences(name, slug, description, venue_id, image, category_id, town_id, indemnity_form, is_disabled, is_private, created_by, created_on, tenant_id, country_id, is_featured)
                                        VALUES (:experienceName, :slug, :description, :venueId, :image, :categoryIdValues, :townId, :indemnityForm, :isDisabled, :isPrivate, :userId, CURRENT_TIMESTAMP, :tenantId, :countryId, :isFeatured)
                                        RETURNING experience_id;");
                    $sth->execute( array(
                        ':experienceName' => $experienceName,
                        ':slug' => $slug,
                        ':description' => $description,
                        ':venueId' => $venueId,
                        ':image' => $image,
                        ':categoryIdValues' => $categoryIdValues,
                        ':townId' => $townId,
                        ':indemnityForm' => $indemnityForm,
                        ':isDisabled' => ($isDisabled == true ? 'TRUE' : 'FALSE'),
                        ':isPrivate' => ($isPrivate == true ? 'TRUE' : 'FALSE'),
                        ':userId' => $userId,
                        ':tenantId' => $tenantId,
                        ':countryId' => $countryId,
                        ':isFeatured' => ($isFeatured == true ? 'TRUE' : 'FALSE')
                    ) );
                    $inserted = $sth->fetch(PDO::FETCH_OBJ);
                    $experienceId = $inserted->experience_id;
                    unset($sth,$inserted);
                }

                // 2. OPEN HOURS
                if ( isset($openHours) && is_array($openHours) ) {
                    try {
                        foreach ($openHours as $hour) {
                            if ( $hour["day_id"] != null && (isset($hour["open_time"]) || isset($hour["close_time"])) ) {
                                $openHourId = null;
    
                                $sth2 = $db->prepare("INSERT INTO kb.experience_open_hours(venue_id, experience_id, day_id, open_time, close_time, created_by, created_on)
                                                        VALUES (:venueId, :experienceId, :dayId, :openTime, :closeTime, :userId, CURRENT_TIMESTAMP)
                                                        ON CONFLICT (venue_id, experience_id, day_id) DO UPDATE
                                                        SET open_time = :openTime,
                                                        close_time = :closeTime,
                                                        updated_on = CURRENT_TIMESTAMP,
                                                        updated_by = :userId
                                                        RETURNING open_hour_id;");
                                $sth2->execute( array(
                                    ':venueId' => $venueId,
                                    ':experienceId' => $experienceId,
                                    ':dayId' => $hour["day_id"],
                                    ':openTime' => $hour["open_time"] ?? null,
                                    ':closeTime' => $hour["close_time"] ?? null,
                                    ':userId' => $userId,
                                ) );
                                $updated = $sth2->fetch(PDO::FETCH_OBJ);
                                $openHourId = $updated->open_hour_id;
                                unset($sth2,$updated);
    
                                // 3. TIMESLOTS
                                if ( isset($hour["time_slots"]) && is_array($hour["time_slots"]) ) {
                                    foreach ($hour["time_slots"] as $slot) {
                                        if ( $slot["interval"] != null || $slot["start_time"] != null ) {
                                            // if the id is null then insert, if it exists then update

                                            if (!isset($slot["id"])) {
                                                // insert
                                                $sth3 = $db->prepare("INSERT INTO kb.experience_timeslots(experience_id, open_hour_id, start_time, end_time, use_time_interval, time_interval, created_by, created_on, max_people_per_slot)
                                                                    VALUES (:experienceId, :openHourId, :startTime, :endTime, :useTimeInterval, :timeInterval, :userId, CURRENT_TIMESTAMP, :maxPeoplePerSlot);");
                                                $sth3->execute( array(
                                                    ':experienceId' => $experienceId,
                                                    ':openHourId' => $openHourId,
                                                    ':startTime' => $slot["start_time"] ?? null,
                                                    ':endTime' => $slot["end_time"] ?? null,
                                                    ':useTimeInterval' => isset($slot["interval"]) ? 'TRUE' : 'FALSE',
                                                    ':timeInterval' => isset($slot["interval"]) ? (int)$slot["interval"] : null,
                                                    ':userId' => $userId,
                                                    ':maxPeoplePerSlot' => isset($slot["max_people_per_slot"]) ? (int)$slot["max_people_per_slot"] : null,
                                                ) );
                                                unset($sth3);
                                            }

                                            if (isset($slot["id"]) && is_int($slot["id"])) {
                                                // update
                                                $sth3 = $db->prepare("UPDATE kb.experience_timeslots SET start_time = :startTime, end_time = :endTime, use_time_interval = :useTimeInterval, time_interval = :timeInterval, updated_by = :userId, updated_on = CURRENT_TIMESTAMP, max_people_per_slot = :maxPeoplePerSlot
                                                                    WHERE timeslot_id = :timeSlotId;");
                                                $sth3->execute( array(
                                                    ':timeSlotId' => (int)$slot["id"],
                                                    ':startTime' => $slot["start_time"] ?? null,
                                                    ':endTime' => $slot["end_time"] ?? null,
                                                    ':useTimeInterval' => isset($slot["interval"]) ? 'TRUE' : 'FALSE',
                                                    ':timeInterval' => isset($slot["interval"]) ? (int)$slot["interval"] : null,
                                                    ':userId' => $userId,
                                                    ':maxPeoplePerSlot' => isset($slot["max_people_per_slot"]) ? (int)$slot["max_people_per_slot"] : null,
                                                ) );
                                                unset($sth3);
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    } catch(PDOException $e2) {
                        $payload = json_encode(array('response' => 'error', 'code' => 2, 'message' => $e2->getMessage()));
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                    }
                }

                // 4. TICKET TYPES
                if ( isset($ticketTypes) && is_array($ticketTypes) ) {
                    try {
                        foreach ($ticketTypes as $ticket) {
                            // if the id is null then insert, if it exists then update

                            $dayId = null;

                            if (!isset($ticket["id"])) {
                                // insert
                                $sth4 = $db->prepare("INSERT INTO kb.experience_ticket_types(experience_id, name, price, is_disabled, limit_per_day, group_ticket, group_quantity, max_per_customer, day_id, created_on, created_by)
                                                    VALUES (:experienceId, :experienceName, :experiencePrice, :isDisabled, :limitPerDay, :isGroupTicket, :groupQty, :maxPerCustomer, :dayId, CURRENT_TIMESTAMP, :userId);");
                                $sth4->execute( array(
                                    ':experienceId' => $experienceId,
                                    ':experienceName' => $ticket["name"] ?? '',
                                    ':experiencePrice' => isset($ticket["price"]) ? (int)$ticket["price"] : 10000,
                                    ':isDisabled' => isset($ticket["is_disabled"]) && $ticket["is_disabled"] == true ? 'TRUE' : 'FALSE',
                                    ':limitPerDay' => isset($ticket["limit_per_day"]) ? (int)$ticket["limit_per_day"] : null,
                                    ':isGroupTicket' => isset($ticket["group_ticket"]) && $ticket["group_ticket"] == true ? 'TRUE' : 'FALSE',
                                    ':groupQty' => isset($ticket["group_quantity"]) ? (int)$ticket["group_quantity"] : null,
                                    ':maxPerCustomer' => isset($ticket["max_per_customer"]) ? (int)$ticket["max_per_customer"] : null,
                                    ':dayId' => $dayId ?? null,
                                    ':userId' => $userId,
                                ) );
                                unset($sth4);
                            }

                            if (isset($ticket["id"])) {
                                // update
                                $sth4 = $db->prepare("UPDATE kb.experience_ticket_types SET name = :experienceName, price = :experiencePrice, is_disabled = :isDisabled, limit_per_day = :limitPerDay, group_ticket = :isGroupTicket, group_quantity = :groupQty, max_per_customer = :maxPerCustomer, day_id = :dayId, updated_on = CURRENT_TIMESTAMP, updated_by = :userId
                                                    WHERE experience_ticket_type_id = :experienceTicketTypeId;");
                                $sth4->execute( array(
                                    ':experienceTicketTypeId' => (int)$ticket["id"],
                                    ':experienceName' => $ticket["name"] ?? '',
                                    ':experiencePrice' => isset($ticket["price"]) ? (int)$ticket["price"] : 10000,
                                    ':isDisabled' => isset($ticket["is_disabled"]) && $ticket["is_disabled"] == true ? 'TRUE' : 'FALSE',
                                    ':limitPerDay' => isset($ticket["limit_per_day"]) ? (int)$ticket["limit_per_day"] : null,
                                    ':isGroupTicket' => isset($ticket["group_ticket"]) && $ticket["group_ticket"] == true ? 'TRUE' : 'FALSE',
                                    ':groupQty' => isset($ticket["group_quantity"]) ? (int)$ticket["group_quantity"] : null,
                                    ':maxPerCustomer' => isset($ticket["max_per_customer"]) ? (int)$ticket["max_per_customer"] : null,
                                    ':dayId' => $dayId ?? null,
                                    ':userId' => $userId,
                                ) );
                                unset($sth4);
                            }
                        }
                    } catch(PDOException $e3) {
                        $payload = json_encode(array('response' => 'error', 'code' => 3, 'message' => $e3->getMessage()));
                        $response->getBody()->write($payload);
                        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
                    }
                }

                // 5. ADDONS / EXTRAS
                if ( isset($addons) && is_array($addons) ) {
                    foreach ($addons as $addon) {
                        if (!isset($addon["id"])) {
                            // insert
                            $sth5 = $db->prepare("INSERT INTO kb.concessions(name, unit_price, icon, created_at, updated_by, max_selectable, min_selectable, experience_id)
                                                    VALUES (:addonName, :addonPrice, :icon, CURRENT_TIMESTAMP, :userId, :maxSelectable, :minSelectable, :experienceId);");
                            $sth5->execute( array(
                                ':addonName' => $addon["name"] ?? '',
                                ':addonPrice' => (int)$addon["price"] ?? 10000,
                                ':icon' => $addon["image"] ?? null,
                                ':userId' => $userId,
                                ':maxSelectable' => (int)$addon["max_selectable"] ?? null,
                                ':minSelectable' => (int)$addon["min_selectable"] ?? null,
                                ':experienceId' => $experienceId,
                            ) );
                            unset($sth5);
                        }

                        if (isset($addon["id"])) {
                            // update
                            $sth5 = $db->prepare("UPDATE kb.concessions SET name = :addonName, unit_price = :addonPrice, icon = :icon, updated_at = CURRENT_TIMESTAMP, 
                                                    updated_by = :userId, max_selectable = :maxSelectable, min_selectable = :minSelectable
                                                    WHERE experience_id = :experienceId AND concession_id = :addonId;");
                            $sth5->execute( array(
                                ':addonName' => $addon["name"] ?? '',
                                ':addonPrice' => (int)$addon["price"] ?? 10000,
                                ':icon' => $addon["image"] ?? null,
                                ':userId' => $userId,
                                ':maxSelectable' => (int)$addon["max_selectable"] ?? null,
                                ':minSelectable' => (int)$addon["min_selectable"] ?? null,
                                ':experienceId' => $experienceId,
                                ':addonId' => $addon["id"],
                            ) );
                            unset($sth5);
                        }
                    }
                }

                $payload = json_encode(array('response' => 'success', 'data' => 'Completed Successfully'));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
                
            } catch(PDOException $e) {
                $payload = json_encode(array('response' => 'error', 'code' => 1, 'message' => $e->getMessage()));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }
            
        })->setName('send-batch-sms');

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
                                                    l.name AS venue_name, dpo_trans_id, mpesa_ref, date_trunc('second', xt.created_on) AS created_on, xt.total_cost AS cost, 
                                                    d.ticket_details
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
                                                    l.name AS venue_name, dpo_trans_id, mpesa_ref, date_trunc('second', xt.created_on) AS created_on, xt.total_cost AS cost, 
                                                    d.ticket_details
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
                                    if (is_array($orders[$i]->ticket_details)) {
                                        for ($j = 0; $j < count($orders[$i]->ticket_details); $j++) {
                                            $orders[$i]->ticket_details[$j]->indemnitors = json_decode($orders[$i]->ticket_details[$j]->indemnitors);
                                        }
                                    }
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

    $group->group('/journey', function (RouteCollectorProxy $group) {
        // Route for accessing front end experiences
        $group->map(['POST', 'GET', 'DELETE', 'PATCH', 'PUT'], '/{id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Find, delete, patch or replace user identified by $args['id']
            // ...
            return $response;
        })->setName('stores-front-end-endpoints');

        // list main stores
        $group->get('/list-main-stores', function (Request $request, Response $response, array $args) {
            // Route: /stores/journey/list-main-stores
            
            try
            {
                $db = getPgDB();
                $sth = $db->prepare("SELECT s.store_id, s.name AS store_name, s.town_id,  s.logo, 
                                        t.town AS store_town, s.country_id, c.country, a3, dial, currency,
                                        COUNT(CASE WHEN b.is_enabled IS TRUE THEN 1 END) AS store_count
                                    FROM stores.stores s
                                    LEFT JOIN public.towns t USING (town_id)
                                    LEFT JOIN public.countries c ON s.country_id = c.country_id
                                    LEFT JOIN stores.branches b USING (store_id)
                                    GROUP BY s.store_id, t.town, c.country, a3, dial, currency
                                    ORDER BY store_id ASC");
                $sth->execute( array() );
                $stores = $sth->fetchAll(PDO::FETCH_OBJ);

                $payload =   json_encode(array('response' => 'success', 'data' => $stores ));
                unset($db,$sth,$stores);

                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('list-stores-app-api');

        // list store's branches
        $group->get('/list-store-branches/{store_id:[0-9]+}', function (Request $request, Response $response, array $args) {
            // Route: /stores/journey/list-store-branches/{store_id}

            $storeId = $args['store_id'] ?? null;
            
            try
            {
                $db = getPgDB();

                $sth = $db->prepare("SELECT b.branch_id, b.name AS branch_name, t.town AS branch_town, b.address,
                                        b.gps_coordinates AS branch_gps, b.open_time, b.close_time, b.is_24_hrs,
                                        b.icon AS branch_logo
                                    FROM stores.branches b
                                    LEFT JOIN public.towns t USING (town_id)
                                    WHERE b.store_id = :storeId");
                $sth->execute( array( ':storeId' => $storeId ) );
                $branches = $sth->fetchAll(PDO::FETCH_OBJ);
                unset($db,$sth);

                if ($branches && is_array($branches)) {
                    for ($i=0; $i < count($branches); $i++) { 
                        if (preg_match("/\((-?\d+\.\d+),(-?\d+\.\d+)\)/", $branches[$i]->branch_gps, $matches)) {
                            $branches[$i]->latitude = $matches[1];   // First captured group is the latitude
                            $branches[$i]->longitude = $matches[2];  // Second captured group is the longitude
                        } else {
                            $branches[$i]->latitude = null;
                            $branches[$i]->longitude = null;
                        }
                    }
                }

                $payload =   json_encode(array('response' => 'success', 'data' => $branches ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
            }
            catch(PDOException $e) {
                $payload =   json_encode(array('response' => 'error', 'message' => $e->getMessage() ));
                $response->getBody()->write($payload);
                return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
            }

        })->setName('list-branches-app-api');

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

                                        $sth3 = $db->prepare("INSERT INTO kb.experience_tickets_details_extras(experience_ticket_detail_id, extra_name, selected_qty, cost, experience_ticket_id)
                                                            VALUES (:experience_ticket_detail_id, :addon_name, :addon_qty, :addon_cost, :cutomer_ticket_id);");
                                        $sth3->execute( array( 
                                            ':experience_ticket_detail_id' => $experience_ticket_detail_id,
                                            ':addon_name' => $addon_name, 
                                            ':addon_qty' => $addon_qty,
                                            ':addon_cost' => $addon_cost, 
                                            ':cutomer_ticket_id' => $cutomer_ticket_id
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

?>