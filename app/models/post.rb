# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class Post < ActiveRecord::Base
  include Shared::Callbacks

  belongs_to :user
  counter_culture :user
  acts_as_votable
  has_many :comments, :as => :commentable, :dependent => :destroy


  include PublicActivity::Model
  tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }

  default_scope -> { order('created_at DESC') }

  mount_uploader :attachment, AvatarUploader

  validates_presence_of :content
  validates_presence_of :user


end
