node.set['rbenv']['user_installs'] = [
  { 'user'    => 'vagrant',
    'rubies'  => ['2.3.0'],
    'global'  => '2.3.0',
    'gems'    => {
      '2.3.0'    => [
        { 'name' => 'bundler' },
      ],
      '3.1.6' => [
        { 'name' => 'jekyll' }
      ]
    }
}
]

include_recipe 'ruby_build'
include_recipe 'ruby_rbenv::user'


directory '/opt/sites/jekyll' do
  recursive true
  owner 'vagrant'
end
