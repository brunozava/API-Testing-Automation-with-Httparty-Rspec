module Helpers

    def get_token(user)
            result = Books.post(
                '/api/token',
                body: {
                    email: user[:email],
                    password: user[:password]
        }.to_json
    )
    return result.parsed_response['account_token']
    end

    def books
       [
                {
                    title: 'A culpa é das estrelas',
                    author: 'John Green',
                    tags: [
                        'Literatura romance'
                    ]
                },
                {
                    title: 'Pai rico pai pobre',
                    author: 'Robert K',
                    tags: [
                        'Literatura'
                    ]   
                },
                {
                    title: 'Testing Future',
                    author: 'Jason x',
                    tags: [
                        'Literatura Estrangeira',
                        'Rock'
                    ]
                },
                {
                    title: 'Testando com Rspec',
                    author: 'Zava',
                    tags: [
                        'Programação',
                        'Testing',
                        'Rspec'
                    ]
                }
            ]
    end

end