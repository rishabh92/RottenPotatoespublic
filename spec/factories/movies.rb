FactoryGirl.define do
    factory :movie do
        title 'A Fake Title'
        rating 'R'
        release_date { 10.years.ago }
    end
    
	it 'should include rating and year' do
	    movie=FactoryGirl.build(:movie,:title=>'Milk')
	end
end