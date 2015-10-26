require 'rails_helper'
require 'spec_helper'

describe Movie do
    describe 'searching Tmdb by keyword' do 
        describe 'with a valid keyword' do 
            before :each do
                expect(Tmdb::Movie).to receive(:find).with('Inception')
            end
            it 'should return a array of movies' do
                expect(Movie.find_in_tmdb('Inception')).to be_an_instance_of(Array)
            end
            it 'should call Tmdb with title keywords' do
                Movie.find_in_tmdb('Inception')
            end
        end
        describe 'with a invalid keyword' do
            describe 'when no movie exist' do
                it 'should return an empty array' do
                    expect(Tmdb::Movie).to receive(:find).with('')
                    expect(Movie.find_in_tmdb('')).to eq []
                end
            end
            context	'with invalid key' do	
			it	'should	raise InvalidKeyError if	key	is	missing	or	invalid'	do	
				allow(Tmdb::Movie).to	receive(:find).and_raise(NoMethodError)	
				allow(Tmdb::Api).to	receive(:response).and_return({'code'	=>	'401'})	
					
			    end	
			end	
        end
        
    end
     
end