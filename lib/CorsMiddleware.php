<?php

namespace ShoppeCors\Middleware;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface;

class CorsMiddleware
{
    public function __invoke(Request $request, RequestHandlerInterface $handler): Response
    {
        $response = $handler->handle($request);

        // Check the origin of the request
        $origin = $request->getHeaderLine('Origin');

        if ($this->isValidOrigin($origin)) {
            // Set CORS headers
            $response = $response
            ->withHeader('Access-Control-Allow-Origin', $origin)
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
            ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
        }

        return $response;
    }

    // Helper function to validate origin
    private function isValidOrigin(string $origin): bool
    {
        // Allow requests from localhost:4000 and https://kenyabuzz.com
        return in_array(
            $origin, 
            [
                'http://localhost', 
                'http://localhost:4000', 
                'http://localhost:4200', 
                'https://kenyabuzz.com', 
                'https://portal.kenyabuzz.com', 
                'https://magicalkenya.com',
                'https://api.kenyabuzz.com',
                'https://api-v3.kenyabuzz.com',
                'https://api-lb.kenyabuzz.com',
                'https://api-lbv2.kenyabuzz.com',
            ]
        );
    }
}
