package com.zayats.authprovider;

import org.springframework.security.core.userdetails.UserDetails;

public interface UserDetailsExt extends UserDetails {
    public Integer getUserId();
}
