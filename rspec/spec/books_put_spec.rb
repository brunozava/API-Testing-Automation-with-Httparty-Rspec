describe('POST /api/books') do
    before(:all) do
        @user = {
            name: 'BrunoMarvin',
            email: 'zava@Marvin.com',
            password: '444444'
        }

        Books.delete("/api/accounts/#{@user[:email]}")
        Books.post('/api/accounts', body: @user.to_json)

        @token = @result.parsed_response['account_token']
        
    end

    describe('status 200') do

        before(:all) do
            @book = {
                title: 'Learning rspec',
                author: 'Unknown',
                tags: [
                    'Ruby',
                    'Testes'
                ]
            }

            Books.post(
                'api/books',
                body: @book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )

            @book = Books.get(
                '/api/books',
                query: {title: @book[:title]},
                headers: {'ACCESS_TOKEN' => @token }
            )

            @book = result.first
        end

        it('atualiza dados do livro') do
           
            @change_book = {
                title: 'Aprendendo HTTParty com rspec',
                author: 'Zava',
                tags: [
                    'Ruby',
                    'Testes',
                    'HTTParty'
                ]
            }
        
            @result = Books.put(
                "api/books/#{@book['id']}'",
                body: @change_book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )
    
            expect(@result.response.code).to eql '200'

            @target = @result.parsed_response

            expect(@target['title']).to eql @change_book[:title]
            expect(@target['tags']).to eql @change_book[:tags]

        end

        it('quando o livro já foi cadastrado') do
            @result = Books.post(
                'api/books',
                body: @book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )

            expect(@result.response.code).to eql '200'

            expect(
                @result.parsed_response['message']
            ).to eql "O livro com título #{@book[:title]}, já está cadastrado."
        end
    end

    describe('status 404') do
        it('quando o livro não é encontrado') do

            @change_book = {
                title: 'Aprendendo HTTParty com rspec',
                author: 'Zava',
                tags: [
                    'Ruby',
                    'Testes',
                    'HTTParty'
                ]
            }

            @result = Books.put(
                "/api/books/#{Faker::Lorem.characters(25)}",
                body: @book.to_json, 
                headers: {'ACCESS_TOKEN' => @token }
            )
            expect(@result.response.code).to eql '404'
            expect(
                @result.parsed_response['message']
            ).to eql 'Livro não encontrado.'
        end
    end

    after(:each) do |example|
        puts @result.parsed_response if example.exception
    end
end
    