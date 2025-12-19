# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require 'himekuri'
require 'sinatra'
require 'sinatra/reloader'
require 'version'
require 'zella'
require 'json'
require 'net/http'
require 'uri'

# class katana is mumei and slogan
class Katana
  attr_accessor :mumei, :slogan

  def initialize(mumei, slogan)
    @mumei = mumei
    @slogan = slogan
  end
end

get '/' do
  @ruby = ('Ruby_VERSION : ' + RUBY_VERSION + ' ' + 'Sinatra_VERSION : ' + Sinatra::VERSION)
  @himekuri = HimekuriClass.new.himekuri
  @reiwa = HimekuriClass.new.reiwa
  @year = DateTime.now.year
  @zella = Zella.formula
  @takkii = ' Takayuki Kamiyama All Rights Reserved. '
  @saya = Katana.new('Designed by NyaSoCom', 'Not Yet Another Software design of Computer')
  @nyasocom_version = NYASOCOM::VERSION
  url = 'http://localhost:3000/groups.json'
  uri = URI.parse(url)
  json = Net::HTTP.get(uri)
  result = JSON.parse!(json)
  @names = result[0]['name']
  @titles = result[0]['title']
  @dtcls = result[0]['dtcl']
  @dtcls_full = result[0]['dtcl_full']
  @neovims = result[0]['neovim']
  @jetbrains = result[0]['jetbrain']
  @reasons = result[0]['reason']
  @setting = result[0]['settings']
  @plugin = result[0]['plugins']
  @ide = result[0]['ides']
  @copyrights = result[0]['copyright']
  @author = result[0]['authors']
  @youtubes = result[0]['youtube']
  @unders = result[0]['under']
  @spas = result[0]['spa']
  @spas_full = result[0]['spa_full']
  @spas_dev = result[0]['spa_dev']
  @spas_js = result[0]['spa_js']
  @spas_cm = result[0]['spa_cm']
  @githubs = result[0]['github']
  @githubs_pf = result[0]['github_pf']
  @githubs_op = result[0]['github_op']
  @githubs_us = result[0]['github_us']
  @githubs_me = result[0]['github_me']
  @githubpage = result[0]['githubpages']
  @githubps_pf = result[0]['githubp_pf']
  @githubps_bd = result[0]['githubp_bd']
  @githubps_sy = result[0]['githubp_sy']
  @githubps_old = result[0]['githubp_old']
  @gists = result[0]['gist']
  @gists_p = result[0]['gist_p']
  @gists_op = result[0]['gist_op']
  @gists_sh = result[0]['gist_sh']
  @gists_mix = result[0]['gist_mix']
  erb :index
end
