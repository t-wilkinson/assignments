package com.treywilkinson.learn;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.concurrent.atomic.AtomicLong;

@RestController
public class HelloController {
  private static final String template = "hello %s!";
  private final AtomicLong counter = new AtomicLong();

  @GetMapping("/hello")
  public String sayHello() {
    return "Hello, WGU Student!";
  }

  @GetMapping("/greeting")
  public Greeting greeting(@RequestParam(defaultValue = "World") String name) {
    return new Greeting(counter.incrementAndGet(), template.formatted(name));
  }
}
