<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\HistoryController;

Route::post(
    '/register',
    [AuthController::class,
    'register']
);

Route::post(
    '/login',
    [AuthController::class,
    'login']
);

/// SAVE HISTORY
Route::post(
    '/history',
    [HistoryController::class,
    'store']
);

/// GET HISTORY USER
Route::get(
    '/history/{id}',
    [HistoryController::class,
    'index']
);

Route::get(
    '/trend/{id}',
    [HistoryController::class,
    'trend']
);