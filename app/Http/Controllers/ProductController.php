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

        // check of prooduct voorraad heeft
        if (!empty($leveringen) && $leveringen[0]->AantalAanwezig == 0) {
            return view('products.leverantie-info', [
                'title' => 'Levering Informatie',
                'leveringen' => [],
                'leverancier' => !empty($leverancier) ? $leverancier[0] : null,
                'noStock' => true,
                'nextDelivery' => !empty($leveringen) ? $leveringen[0]->DatumEerstVolgendeLevering : null
            ]);
        }

        return view('products.leverantie-info', [
            'title' => 'Levering Informatie',
            'leveringen' => $leveringen,
            'leverancier' => !empty($leverancier) ? $leverancier[0] : null,
            'noStock' => false
        ]);
    }

    public function allergenenInfo($id)
    {
        $allergenen = $this->productModel->sp_GetProductAllergenen($id);

        // check of product allergenen heeft
        if (empty($allergenen)) {
            return view('products.allergenen-info', [
                'title' => 'Overzicht Allergenen',
                'allergenen' => [],
                'product' => null,
                'noAllergens' => true
            ]);
        }

        return view('products.allergenen-info', [
            'title' => 'Overzicht Allergenen',
            'allergenen' => $allergenen,
            'product' => $allergenen[0],
            'noAllergens' => false
        ]);
    }
}