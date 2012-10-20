
class MoviesController < ApplicationController
    
    def show
#         if Movie.find_by_id(params[:id]) != nil
#             @movies = Movie.find(params[:id])
#         else
#             flash[:notice] = "the movie requested #{params[:id]} does not exist"
#             redirect_to movies_path
#         end
        begin
            @movies = Movie.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            flash[:notice] = "the movie requested #{params[:id]} does not exist"
            redirect_to movies_path
        end
    end

    def index
        @movies = Movie.all
        @movies = Movie.find(:all, :order => 'title')
    end
    
    def new
#         @movies = Movie.new
    end
    
    def create
        if params['commit'] != "Cancel"
            @movies = Movie.create!(params[:movie])
            flash[:notice] = "#{@movies.title} was successfully created."
            redirect_to movies_path+("/#{@movies.id}")
        else
            redirect_to movies_path
        end
    end
    
    def edit
        @movies = Movie.find params[:id]
    end
    
    def update
        @movies = Movie.find params[:id]
        if params['commit'] != "Cancel"
            @movies.update_attributes!(params[:movie])
            flash[:notice] = "#{@movies.title} was successfully updated."
        end
        redirect_to movie_path(@movies.id)
    end
    
    def destroy
        @movies = Movie.find params[:id]
        @movies.destroy
        flash[:notice] = "Movie '#{@movies.title}' deleted."
        redirect_to movies_path
    end
end
