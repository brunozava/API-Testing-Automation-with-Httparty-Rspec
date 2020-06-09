describe('GET /api/books') do

    before(:all) do
        @user = {
            name: 'Zava Jones',
            email: 'zavajones@test.com',
            password: '918171'
        }

        Books.delete("/api/accounts/#{@user[:email]}")
        Books.post(
            '/api/accounts',
            body: @user.to_json
        )

        @token = get_token(@user)
    end

    describe('status 200') do

        before(:all) do
            books.each do |book|
                Books.post(
                'api/books',
                body: book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )
        end
        
        @result = Books.get(
            '/api/books',
            headers: {'ACCESS_TOKEN' => @token }
        )

        @book = @result.parsed.response.sample
    end
        it('buscar um único livro') do
            @result = Books.get(
                "/api/books/#{@book['id']}",
                headers: {'ACCESS_TOKEN' => @token }
            )

            expect(@result.response.code).to eql '200'
            expect(
            @result.parsed_response
            ).to eql @book
        end
    end

    describe('status 404') do
        it('quando o ID do livro não existe') do
            @result = Books.get(
                "/api/books/#{Faker::Lorem.characters(25)}",
                headers: {'ACCESS_TOKEN' => @token }
            )
            expect(@result.response.code).to eql '404'
            expect(
                @result.parsed_response['message']
            ).to eql 'Livro não encontrado.'
        end
    end
        

        after(:each) do |example|
            if example.exception
                puts @token
                puts @result.parsed_response
            end
        end
    
end