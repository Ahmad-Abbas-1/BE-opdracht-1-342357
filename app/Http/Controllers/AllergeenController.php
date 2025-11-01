<?php

namespace App\Http\Controllers;

use App\Models\AllergeenModel;
use Illuminate\Http\Request;

class AllergeenController extends Controller
{
    private $allergeenModel;

    public function __construct()
    {
        $this->allergeenModel =  new AllergeenModel();
    }
    public function index()
    {
        $allergenen = $this->allergeenModel->sp_GetAllergenen();

        return view('allergenen.index' , [
            'title' => 'Allergenen',
            'allergenen' => $allergenen
        ]);
    }

    public function create()
    {
        return view('allergenen.create', [
            'title' => 'Voeg een nieuwe allergeen toe'
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name'=> 'required|string|max:50',
            'description'=> 'required|string|max:255'
        ]);

        $newId = $this-> allergeenModel->sp_CreateAllergeen(
            $data['name'],
            $data['description']
        );
        return redirect()->route('allergeen.index')
                         ->with('success', "allergeen is succesvol toegevoegd met id". $newId);
    }

    public function show(AllergeenModel $allergeenModel)
    {
        //
    }

    public function edit($id)
    {
        $allergeen = $this->allergeenModel->sp_GetAllergeenById($id);


        abort_if(!$allergeen, 404);

        return view('allergenen.edit', [
            'title' => 'Bewerk allergeen',
            'allergeen' => $allergeen
        ]);
    }

    public function update(Request $request, $id)
    {
    
        $validated = $request->validate([
            'name'=> 'required|string|max:50',
            'omschrijving'=> 'required|string|max:255'
        ]);

        $affected = $this->allergeenModel->sp_UpdateAllergeen(
            $id,
            $validated['name'],
            $validated['omschrijving']
        );
        if ($affected === 0) {
            return back()->with('error', 'Er is niets gewijzigd of error bestaat niet');
        }

        return redirect()->route('allergeen.index')
                         ->with('success', "Allergeen is succesvol bijgewerkt");
    }


    public function destroy($id)
    {
        $result = $this->allergeenModel->sp_DeleteAllergeen($id);

        if ($result > 0) {
           return redirect()->route('allergeen.index')
                             ->with('success', 'Allergeen is succesvol verwijderd.');
        }

        return redirect()->route('allergeen.index')
                         ->with('error', 'Er is iets misgegaan bij het verwijderen van de allergeen.');
    }
}
