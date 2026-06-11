<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AuthController extends Controller
{
    // REGISTER
    public function register(Request $request)
    {
        // validasi
        $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);

        // simpan user
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        // buat token
        return response()->json([
            'message' => 'Register berhasil',
            'user' => $user
        ], 201);
    }

    // LOGIN
    public function login(Request $request)
    {
        // validasi
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // cek email
        $user = User::where(
            'email',
            $request->email
        )->first();

        // cek password
        if (
            !$user ||
            !Hash::check(
                $request->password,
                $user->password
            )
        ) {
            return response()->json([
                'message' =>
                'Email atau password salah'
            ], 401);
        }

        // buat token
        $token = $user
            ->createToken(
                'auth_token'
            )->plainTextToken;

        // simpan token ke database
        return response()->json([
            'message' =>
            'Login berhasil',

            'token' => $token,

            'user' => $user
        ]);
    }
}