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
    public function trend($id, Request $request)
    {
        $type = $request->type ?? 'weekly';

        $history = HistoriZikir::where(
            'user_id',
            $id
        )->get();

        $result = [];

        /// HARIAN (7 hari)
        if ($type == 'daily') {

            $days = [
                'Mon' => 'Sen',
                'Tue' => 'Sel',
                'Wed' => 'Rab',
                'Thu' => 'Kam',
                'Fri' => 'Jum',
                'Sat' => 'Sab',
                'Sun' => 'Min'
            ];

            foreach ($days as $day => $indo) {

                $total = $history
                    ->filter(function ($item)
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
                    'label' => $indo,
                    'total' => $total,
                ];
            }
        }

        /// MINGGUAN (4 minggu terakhir)
        else if ($type == 'weekly') {

            for ($i = 3; $i >= 0; $i--) {

                $start =
                now()->subWeeks($i)
                ->startOfWeek();

                $end =
                now()->subWeeks($i)
                ->endOfWeek();

                $total = $history
                    ->filter(function ($item)
                    use ($start, $end) {

                        $tanggal =
                        strtotime(
                            $item->tanggal
                        );

                        return $tanggal >=
                        strtotime($start)
                        &&
                        $tanggal <=
                        strtotime($end);
                    })
                    ->sum('jumlah');

                $result[] = [
                    'label' =>
                    'Mg' . (4 - $i),
                    'total' =>
                    $total,
                ];
            }
        }

        /// BULANAN (12 bulan)
        else if ($type == 'monthly') {

            for ($i = 11; $i >= 0; $i--) {

                $month =
                now()->subMonths($i);

                $total = $history
                    ->filter(function ($item)
                    use ($month) {

                        return date(
                            'Y-m',
                            strtotime(
                                $item->tanggal
                            )
                        )
                        ==
                        $month
                        ->format('Y-m');
                    })
                    ->sum('jumlah');

                $bulanIndo = [
                    'Jan' => 'Jan',
                    'Feb' => 'Feb',
                    'Mar' => 'Mar',
                    'Apr' => 'Apr',
                    'May' => 'Mei',
                    'Jun' => 'Jun',
                    'Jul' => 'Jul',
                    'Aug' => 'Agu',
                    'Sep' => 'Sep',
                    'Oct' => 'Okt',
                    'Nov' => 'Nov',
                    'Dec' => 'Des',
                ];

                $result[] = [
                    'label' =>
                    $bulanIndo[
                        $month
                        ->format('M')
                    ],

                    'total' =>
                    $total,
                ];
            }
        }

        /// TAHUNAN (5 tahun)
        else if ($type == 'yearly') {

            for ($i = 4; $i >= 0; $i--) {

                $year =
                now()->subYears($i)
                ->year;

                $total = $history
                    ->filter(function ($item)
                    use ($year) {

                        return date(
                            'Y',
                            strtotime(
                                $item->tanggal
                            )
                        ) == $year;
                    })
                    ->sum('jumlah');

                $result[] = [
                    'label' =>
                    (string) $year,

                    'total' =>
                    $total,
                ];
            }
        }

        return response()
            ->json($result);
}
}