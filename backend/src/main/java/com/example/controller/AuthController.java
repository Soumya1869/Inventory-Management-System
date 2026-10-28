package com.example.controller;

import com.example.dto.AuthRequest;
import com.example.dto.AuthResponse;
import com.example.dto.RegisterRequest;
import com.example.dto.UserResponse;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.security.JwtTokenUtil;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody AuthRequest authenticationRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(authenticationRequest.getUsername(),
                        authenticationRequest.getPassword()));

        final UserDetails userDetails = userDetailsService
                .loadUserByUsername(authenticationRequest.getUsername());

        final String token = jwtTokenUtil.generateToken(userDetails);

        return ResponseEntity.ok(new AuthResponse(token));
    }

    @PostMapping("/register")
    public ResponseEntity<UserResponse> saveUser(@Valid @RequestBody RegisterRequest request) {
        User user = new User();
        user.setUserName(request.userName());
        user.setPassword(passwordEncoder.encode(request.password()));
        user.setUserEmail(request.userEmail());
        user.setUserFname(request.userFname());
        user.setUserLname(request.userLname());

        User savedUser = userRepository.save(user);
        UserResponse response = new UserResponse(
                savedUser.getUserId(),
                savedUser.getUserName(),
                savedUser.getUserEmail(),
                savedUser.getUserFname(),
                savedUser.getUserLname());

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
