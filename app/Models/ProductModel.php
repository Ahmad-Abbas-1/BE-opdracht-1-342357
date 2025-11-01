<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ProductModel extends Model
{
    public function sp_GetProducts()
    {
        return DB::select('CALL sp_GetProducts()');
    }

    public function sp_GetLeverancierInfo($productId)
    {
        return DB::select('CALL sp_GetLeverancierInfo(?)', [$productId]);
    }

    public function sp_GetLeverantieInfo($productId)
    {
        return DB::select('CALL sp_GetLeverantieInfo(?)', [$productId]);
    }
}