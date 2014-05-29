package com.zayats.authprovider;

import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;
import java.util.HashSet;

public class UserDetailsImpl implements UserDetailsExt {

    private Collection<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
    private String password;
    private String username;
    private int id;

    public UserDetailsImpl(String username, String password, int id,
                           Collection<GrantedAuthority> authorities) {
        this.username = username;
        this.password = password;
        this.id = id;
        this.authorities = authorities;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.authorities;
    }

    public String getPassword() {
        return this.password;
    }

    public String getUsername() {
        return this.username;
    }

    public Integer getUserId() {
        return id;
    }

    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return true;
    }

    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    public boolean isEnabled() {
        // TODO Auto-generated method stub
        return true;
    }

}
