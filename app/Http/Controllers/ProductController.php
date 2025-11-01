<?php

namespace App\Http\Controllers;

use App\Models\ProductModel;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    private $productModel;

    public function __construct()
    {
        $this->productModel = new ProductModel();
    }

    public function index()
    {
        $products = $this->productModel->sp_GetProducts();

        return view('products.index', [
            'title' => 'Overzicht Magazijn Jamin',
            'products' => $products
        ]);
    }

    public function leverantieInfo($id)
    {
        $leveringen = $this->productModel->sp_GetLeverancierInfo($id);
        $leverancier = $this->productModel->sp_GetLeverantieInfo($id);

        return view('products.leverantie-info', [
            'title' => 'Levering Informatie',
            'leveringen' => $leveringen,
            'leverancier' => !empty($leverancier) ? $leverancier[0] : null,
            'noStock' => false
        ]);
    }

}