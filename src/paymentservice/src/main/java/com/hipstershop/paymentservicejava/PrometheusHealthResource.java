package com.hipstershop.paymentservicejava;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
public class PrometheusHealthResource {

    @GetMapping("/health")
    public String getStatus(@RequestParam(name = "scope", defaultValue = "default") String param) {
        return "ok";
    }
}
