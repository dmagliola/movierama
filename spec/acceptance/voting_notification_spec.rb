require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/with_user'

RSpec.describe 'user is notified by email when his movies receive love/hate', type: :feature do
  let(:page) { Pages::MovieList.new }

  before do
    @author = User.create(
      uid:  'null|12345',
      name: 'Bob',
      email: 'bob@bob.com',
      notify_me: 'true',
    )

    @movie = Movie.create(
        title:        'Empire strikes back',
        description:  'Who\'s scruffy-looking?',
        date:         '1980-05-21',
        user:         @author
    )
  end

  context 'when logged in' do
    with_logged_in_user

    before { page.open }

    it 'emails users that want to be notified on like' do
      expect { page.like(@movie.title) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
    it 'emails users that want to be notified on hate' do
      expect { page.like(@movie.title) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    context 'with an author that has opted-out of notifications' do
      before { @author.update(notify_me: false) }

      it 'doesnt email author on like' do
        expect { page.like(@movie.title) }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    context 'with an author that has an empty email address' do
      before { @author.update(email: nil) }

      it 'doesnt email author on like' do
        expect { page.like(@movie.title) }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end



