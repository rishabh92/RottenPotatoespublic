require 'rails_helper'
require 'spec_helper'


describe MoviesController do
    describe 'searching TMDb' do	
	    it 'should call the model method that performs TMDb search' do
	       @fake_results = [double('movie1'), double('movie2')]
           expect(Movie).to receive(:find_in_tmdb).with('Ted').and_return(@fake_results)
           post :search_tmdb, {:search_terms => 'Ted'} 
        end
        describe 'with no search results' do
            it 'should show a flash message no movie matched' do
                post :search_tmdb, {:search_terms => '!!!!'}
                expect(flash[:notice])== "No matching movies were found on TMDb"
            end
            it 'should return an empty array' do
                post :search_tmdb, {:search_terms => '!!!!'}
                expect(assigns(:movies)).to eq []
                expect(response).to redirect_to('/movies')
            end
		end
		describe 'invalid search input term' do
		    it 'should flash a message message' do
		        post :search_tmdb, {:search_terms => ''} 
		        expect(flash[:notice]).to eq("Invalid search term")
		        expect(response).to redirect_to('/movies')
		    end
		end
		describe 'valid search results' do
            it 'should select the Search Results template for rendering' do
                Movie.stub(:find_in_tmdb).and_return(@fake_results)
                post :search_tmdb, { :search_terms => 'Ted' }
                response.should render_template('search_tmdb')
                
            end
            it 'should make the TMDb search results available to that template' do
                Movie.stub(:find_in_tmdb).and_return(@fake_results)
                post :search_tmdb, { :search_terms => 'hardware' }
                assigns(:matching_movies).should == @fake_results
                
            end
        end
        
	end
	describe 'selecting and adding a new movie using checkbox' do
	    it 'should call the model method that perform addition' do
	         Movie.should_receive(:create_from_tmdb)
	         post :add_tmdb, {:mov => {:id => 550}}
	         expect(flash[:notice]).to eq("Movie successfully added to Rotten Potatoes")
	         expect(response).to redirect_to('/movies')
	    end
	     it 'should display flash message for no movie selected' do
            post :add_tmdb, {:tmdb_movies => ''}
            expect(flash[:notice]).to eq("No Movies selected")
            expect(response).to redirect_to('/movies')
        end
	    
	end
end	