class Public::HomesController < ApplicationController
  def top
    @postings = Posting.all

  end
end
