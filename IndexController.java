package com.giuggiola.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/error2")
public class IndexController implements ErrorController{

    private static final String PATH = "/error-spring";

    @RequestMapping(value = PATH)
    public String error() {
        return "Error handling";
    }

    public String getErrorPath() {
        return PATH;
    }
}
