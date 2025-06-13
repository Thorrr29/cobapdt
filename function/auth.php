<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function require_login() {
    if (!isset($_SESSION['user_id'])) {
        header("Location: index.php");
        exit();
    }
}

function require_role($role) {
    if (!isset($_SESSION['user_id'])) {
        // Not logged in
        header("Location: index.php");
        exit();
    }
    if (!isset($_SESSION['role']) || $_SESSION['role'] !== $role) {
        // Role mismatch - redirect to login or unauthorized page
        header("Location: index.php?error=" . urlencode("Unauthorized access."));
        exit();
    }
}
