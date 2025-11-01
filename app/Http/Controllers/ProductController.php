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
}