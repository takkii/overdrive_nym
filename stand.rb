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
  remove_frame_k = json.delete!("[")
  remove_frame = remove_frame_k.delete!("]")
  result = JSON.parse!(remove_frame)
  @names = result['name']
  @titles = result['title']
  @dtcls = result['dtcl']
  @dtcls_full = result['dtcl_full']
  @neovims = result['neovim']
  @jetbrains = result['jetbrain']
  @reasons = result['reason']
  @setting = result['settings']
  @plugin = result['plugins']
  @ide = result['ides']
  @copyrights = result['copyright']
  @author = result['authors']
  @youtubes = result['youtube']
  @unders = result['under']
  @spas = result['spa']
  @spas_full = result['spa_full']
  @spas_dev = result['spa_dev']
  @spas_js = result['spa_js']
  @spas_cm = result['spa_cm']
  @githubs = result['github']
  @githubs_pf = result['github_pf']
  @githubs_op = result['github_op']
  @githubs_us = result['github_us']
  @githubs_me = result['github_me']
  @githubpage = result['githubpages']
  @githubps_pf = result['githubp_pf']
  @githubps_bd = result['githubp_bd']
  @githubps_sy = result['githubp_sy']
  @githubps_old = result['githubp_old']
  @gists = result['gist']
  @gists_p = result['gist_p']
  @gists_op = result['gist_op']
  @gists_sh = result['gist_sh']
  @gists_mix = result['gist_mix']
  erb :index
end
