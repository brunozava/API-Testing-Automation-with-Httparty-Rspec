describe('POST /api/books') do
    before(:all) do
        @user = {
            name: 'BrunoZava',
            email: 'zava@zavax.com',
            password: '123456'
        }

        Books.delete("/api/accounts/#{@user[:email]}")
        Books.post('/api/accounts', body: @user.to_json)

        @token = @result.parsed_response['account_token']
        
    end

    describe('status 200') do
        it('cadastrar novo livro') do
            @book = {
                title: 'Transformers',
                author: 'Michael Bay',
                tags: [
                    'Action',
                    'Suspense'
                ]
            }
        
            @result = Books.post(
                'api/books',
                body: @book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )
    
            expect(@result.response.code).to eql '200'
        end
    end

    describe('status 409') do
        before(:all) do
            @book = {
                title: 'ZavaFilme',
                author: 'Zava',
                tags: [
                    'Action',
                    'Suspense'
                ]
            }

            Books.post(
                'api/books',
                body: @book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )
        end
        it('quando o livro já foi cadastrado') do
            @result = Books.post(
                'api/books',
                body: @book.to_json,
                headers: {'ACCESS_TOKEN' => @token }
            )

            expect(@result.response.code).to eql '409'

            expect(
                @result.parsed_response['message']
            ).to eql "O livro com título #{@book[:title]}, já está cadastrado."
        end
    end

    after(:each) do |example|
        puts @result.parsed_response if example.exception
    end

end
    
    