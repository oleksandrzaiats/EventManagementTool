package com.zayats.controller;

import com.zayats.authprovider.UserDetailsExt;

import java.util.HashMap;

public abstract class AuthorizedController {

    private static UserDetailsExt currentUser;

    public static final HashMap<String, String> naviMap;

    static {
        naviMap = new HashMap<String, String>();
        naviMap.put("Home", "/home.html");
        naviMap.put("My Events", "/home/events.html");
        naviMap.put("Tasks", "/home/tasks.html");
        naviMap.put("Invitations", "/home/invitations.html");
    }

    public static UserDetailsExt getCurrentUser() {
        return currentUser;
    }

    public static void setCurrentUser(UserDetailsExt currentUser) {
        AuthorizedController.currentUser = currentUser;
    }
}
