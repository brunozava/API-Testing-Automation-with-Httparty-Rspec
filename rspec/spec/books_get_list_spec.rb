describe('GET /api/books') do

    before(:all) do
        @user = {
            name: 'Zava Joe',
            email: 'zavajoe@test.com',
            password: '654321'
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

        it('listar livros') do
            
            @result = books.get(
                '/api/books',
                headers: {'ACCESS_TOKEN' => @token }
            )

            expect(@result.response.code).to eql '200'
        @list = @result.parsed_response
            expect(@list).not_to be_empty

            @list.each do |item|
                expect(item['title'].class).to eql String
                expect(ite['tags'].class).to eql Array
            end

    @list.each_with_index do |item, index|
        expect(item['title']).to eql books[index][:title]
    end
        end
    end

        after(:each) do |example|
            if example.exception
                puts @token
                puts @result.parsed_response
            end
        end
        end
end