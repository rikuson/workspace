require 'spec_helper'

[
  { 'name' => 'BetterSnapTool', 'id' => 417375580 },
  { 'name' => 'Evernote', 'id' => 406056744 },
  { 'name' => 'Kindle', 'id' => 302584613 },
  { 'name' => 'Logic Pro X', 'id' => 634148309 },
  { 'name' => 'Microsoft Remote Desktop', 'id' => 1295203466 },
  { 'name' => 'PDFOutliner', 'id' => 420874236 },
  { 'name' => 'Save to Pocket', 'id' => 1477385213 },
  { 'name' => 'Spark', 'id' => 1176895641 },
  { 'name' => 'Xcode', 'id' => 497799835 },
  { 'name' => 'Keynote', 'id' => 409183694 },
  { 'name' => 'Adblock Plus for Safari ABP', 'id' => 1432731683 },
].each do |item|
  describe command("mas info #{item['id']}") do
    its(:exit_status) { should eq 0 }
  end
end
