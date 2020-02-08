package ca.ubc.cs304.utils;

import java.util.Arrays;
import java.util.Random;

public class Utility {

    public Utility() {
    }

    public static int generateID() {
        Random random = new Random();
        return random.nextInt(Integer.MAX_VALUE); // stub
    }

    public static String formatLocation(String city, String location) {
        return city + " - " + location;
    }

    public static String getCityFromBranchString(String location) {
        String[] splitString = location.split("-");
        return splitString[0];
    }

    public static String getLocationFromBranchString(String location) {
        String[] splitString = location.split("-");
        return splitString[1];
    }

    public static String[] getNames(Class<? extends Enum<?>> e) {
        return Arrays.stream(e.getEnumConstants()).map(Enum::name).toArray(String[]::new);
    }

    public static boolean isInteger(String str) {
        if (str == null) {
            return false;
        }
        int length = str.length();
        if (length == 0) {
            return false;
        }
        int i = 0;
        if (str.charAt(0) == '-') {
            if (length == 1) {
                return false;
            }
            i = 1;
        }
        for (; i < length; i++) {
            char c = str.charAt(i);
            if (c < '0' || c > '9') {
                return false;
            }
        }
        return true;
    }

}