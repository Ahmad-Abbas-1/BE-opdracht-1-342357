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

            @if ($errors->any())
                <div class="alert alert-danger">
                    <ul class="mb-0">
                        @foreach ($errors->all() as $err)
                            <li>{{ $err }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif


            <form method="POST" action="{{ route('allergeen.update', $allergeen->Id) }}">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label for="InputName" class="form-label">Naam</label>
                    <input name="name" type="text" class="form-control" id="InputName"
                        value="{{ old('name', $allergeen->Naam) }}">

                </div>
                <div class="mb-3">
                    <label for="InputDescription" class="form-label">Omschrijving</label>
                    <input name="omschrijving" type="text" class="form-control" id="InputDescription"
                        aria-describedby="descriptionHelp" value="{{ old('omschrijving', $allergeen->Omschrijving) }}">
                </div>

                <button type="submit" class="btn btn-primary">Opslaan</button>
                <a href="{{ route('allergeen.index') }}" class="btn btn-secondary">Annuleren</a>
            </form>

        </div>
    </div>
</body>

</html>
