@vite(['resources/css/app.css', 'resources/js/app.js'])
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

            <h1>{{ $title }}</h1>

            @if (session('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session('success') }}
                    <button type="button" class="btn-close" aria-label="sluiten" data-bs-dismiss="alert"></button>
                </div>
                <meta http-equiv="refresh" content="3;url={{ route('allergeen.index') }}">
            @endif

            <a href="{{ route('allergeen.create') }}" class="btn btn-primary my-3">Nieuwe Allergeen</a>
        
            <table class="table table-striped table-bordered align-middle shadow-sm">
                <thead>
                    <th>Naam</th>
                    <th>Omschrijving</th>
                    <th class="text-center">Verwijder</th>
                    <th class="text-center">Wijzig</th>
                </thead>
                <tbody>
                    @forelse ($allergenen as $allergeen)
                        <tr>
                            <td>{{ $allergeen->Naam }}</td>
                            <td>{{ $allergeen->Omschrijving }}</td>
                            <td class="text-center">
                                <form action="{{ route('allergeen.destroy', $allergeen->Id) }}" method="POST" 
                                    onsubmit="return confirm('Weet je zeker dat je dit allergeen wilt verwijderen?');">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger">Verwijderen</button>
                                </form>
                            </td>
                            <td class="text-center">
                                <form action="{{ route('allergeen.edit', $allergeen->Id) }}" method="POST">
                                    @csrf
                                    @method('GET')
                                    <button type="submit" class="btn btn-success">Wijzig</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr colspan='3'>Geen allergenen bekent</tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>