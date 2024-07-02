package tech.sgcor.Basic_API.service;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import tech.sgcor.Basic_API.dto.GreetingResponse;
import tech.sgcor.Basic_API.dto.LocationResponse;
import tech.sgcor.Basic_API.dto.WeatherResponse;

@Service
public class GreetingService {
    @Value("${API_KEY}")
    private String apiKey;
    private final RestTemplate restTemplate;
    private final String LOCATION_API_URL = "https://ipapi.co/%s/json/";
    private final String WEATHER_API_BASE_URL = "http://api.weatherapi.com/v1/current.json?key=bcec40cf7656480a8ae162632240207&q=%s";


    public GreetingService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    public GreetingResponse sayHello(String visitorsName, HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        System.out.println("IpAddress: " + ipAddress);

        // Fetch location from third party api
        String locationUrl = String.format(LOCATION_API_URL, ipAddress);
        LocationResponse location = restTemplate.getForObject(locationUrl, LocationResponse.class);
        String city = location != null ? location.getCity() : "Unknown";

        // Fetch weather from third party api
//        String weatherUrl = String.format(WEATHER_API_BASE_URL, ipAddress);
        WeatherResponse weatherResponse = restTemplate.getForObject(WEATHER_API_BASE_URL, WeatherResponse.class);
        double temp = weatherResponse != null ? weatherResponse.getCurrent().getTemp_c(): 0.0;

        String greeting = "Hello, " + visitorsName + ",the temperature is " + (int) temp + " degrees Celcius in " + city;
        return new GreetingResponse(ipAddress, city, greeting);
    }
}
