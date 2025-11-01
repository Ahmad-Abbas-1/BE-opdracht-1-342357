@vite(['resources/css/app.css', 'resources/js/app.js']);
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jamin</title>
</head>
<body>
    <div class="container d-flex justify-content-center">

        <div class="col-md-8">

            <h2>{{ $title }}</h2>


            <form method="POST" action="{{ route('allergeen.store') }}">
                @csrf
                <div class="mb-3">
                    <label for="InputName" class="form-label">Naam</label>
                    <input name="name" type="text" class="form-control" id="InputName" aria-describedby="nameHelp">
                    <div id="nameHelp" class="form-text">Noteer hier de naam van het allergeen</div>
                </div>
                <div class="mb-3">
                    <label for="InputDescription" class="form-label">Omschrijving</label>
                    <input name="description" type="text" class="form-control" id="InputDescription" aria-describedby="descriptionHelp">
                    <div id="descriptionHelp" class="form-text">Noteer hier de omschrijving van het allergeen.</div>
                </div>   
                
                <button type="submit" class="btn btn-primary">Verzend</button>
                <a href="{{ route('allergeen.index') }}" class="btn btn-secondary">Annuleren</a>
            </form>

        </div>
    </div>
</body>
</html>