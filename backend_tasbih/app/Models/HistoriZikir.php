<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HistoriZikir
extends Model
{
    protected $table =
        'histori_zikir';

    protected $fillable = [

        'user_id',

        'nama_dzikir',

        'target',

        'jumlah',

        'tanggal',
    ];
}