@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Overzicht Allergenen</title>
</head>
<body>
    <div class="container d-flex justify-content-center">
        <div class="col-md-8">
            <h1>{{ $title }}</h1>

            @if($noAllergens)
                <div class="alert alert-success mt-4" role="alert">
                    In dit product zitten geen stoffen die een allergische reactie kunnen veroorzaken
                </div>
                <meta http-equiv="refresh" content="4;url={{ route('product.index') }}">
            @else
                @if($product)
                    <div class="card mt-4 mb-4">
                        <div class="card-body">
                            <p><strong>Naam:</strong> {{ $product->ProductNaam }}</p>
                            <p><strong>Barcode:</strong> {{ $product->Barcode }}</p>
                        </div>
                    </div>
                @endif

                <table class="table table-striped table-bordered align-middle shadow-sm">
                    <thead>
                        <tr>
                            <th>Naam</th>
                            <th>Omschrijving</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($allergenen as $allergeen)
                            <tr>
                                <td>{{ $allergeen->Naam }}</td>
                                <td>{{ $allergeen->Omschrijving }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="2" class="text-center">Geen allergenen beschikbaar</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>

                <a href="{{ route('product.index') }}" class="btn btn-secondary mt-3">Terug naar overzicht</a>
            @endif
        </div>
    </div>
</body>
</html>