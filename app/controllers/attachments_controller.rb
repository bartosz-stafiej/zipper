# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def new
    @attachment = Attachment.new
  end

  def index
    @attachments = Attachment.all
  end
end
