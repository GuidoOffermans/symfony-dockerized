<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LuckyController {
    #[Route('/')]
    public function number(): Response {
        $number = random_int(0, 100);

        return new Response(
            '<html><body><h2>Lucky number: ' . $number . '<h2><p>hello world</p></body></html>'
        );
    }
}