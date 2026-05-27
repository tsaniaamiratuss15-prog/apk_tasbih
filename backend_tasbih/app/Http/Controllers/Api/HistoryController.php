<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\HistoriZikir;
use Illuminate\Http\Request;

class HistoryController
extends Controller
{
    /// SAVE HISTORY
    public function store(
        Request $request
    ) {

        HistoriZikir::create([

            'user_id' =>
            $request->user_id,

            'nama_dzikir' =>
            $request
                ->nama_dzikir,

            'target' =>
            $request->target,

            'jumlah' =>
            $request->jumlah,

            'tanggal' =>
            $request->tanggal,
        ]);

        return response()->json([
            'message' =>
            'Berhasil disimpan'
        ]);
    }

    /// GET HISTORY
    public function index(
        $id
    ) {

        return HistoriZikir::where(
            'user_id',
            $id
        )
            ->latest()
            ->get();
    }

    /// GET TREND
    public function trend(
        $id
    )
    {
        $history =
        HistoriZikir::where(
            'user_id',
            $id
        )
        ->where(
            'tanggal',
            '>=',
            now()->subDays(6)
        )
        ->get();

        $days = [
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat',
            'Sun'
        ];

        $result = [];

        foreach ($days as $day) {

            $total =
            $history
            ->filter(
                function ($item)
                use ($day) {

                return date(
                    'D',
                    strtotime(
                        $item->tanggal
                    )
                ) == $day;
            })
            ->sum('jumlah');

            $result[] = [
                'day' =>
                $day,

                'total' =>
                $total,
            ];
        }

        return response()
            ->json(
                $result
            );
    }
}