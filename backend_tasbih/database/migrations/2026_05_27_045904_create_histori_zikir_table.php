<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create(
            'histori_zikir',
            function (
                Blueprint $table
            ) {

            $table->id();

            $table
                ->foreignId(
                    'user_id'
                )
                ->constrained()
                ->onDelete(
                    'cascade'
                );

            // dzikir apa
            $table->string(
                'nama_dzikir'
            );

            // target
            $table->integer(
                'target'
            );

            // total dzikir
            $table->integer(
                'jumlah'
            );

            // tanggal
            $table->date(
                'tanggal'
            );

            $table
                ->timestamps();
        });
    }

    /**
     * Reverse migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists(
            'histori_zikir'
        );
    }
};