require 'spec_helper'

describe Versionarchive do

  describe "create_archive_if_not_exist" do

    it "creates an archive" do
      Versionarchive.count.should eq(0)
      archive = Versionarchive.new({:language => Product::A_LANGUAGE_PHP, :prod_key => "symfony/symfony",
        :version_id => "1.0.0", :name => "symfony", :link => "symfony.de" })
      Versionarchive.create_archive_if_not_exist archive
      Versionarchive.count.should eq(1)
      arch_db = Versionarchive.first
      arch_db.prod_key.should eql("symfony/symfony")
      arch_db.link.should eql("http://symfony.de")

      archive_2 = Versionarchive.new({:language => Product::A_LANGUAGE_PHP, :prod_key => "symfony/symfony",
        :version_id => "1.0.0", :name => "symfony", :link => "symfony.de" })
      Versionarchive.create_archive_if_not_exist archive_2
      Versionarchive.count.should eq(1)

      archive_3 = Versionarchive.new({:language => Product::A_LANGUAGE_PHP, :prod_key => "symfony/doctrine",
        :version_id => "1.0.0", :name => "doctron", :link => "symfony.de" })
      Versionarchive.create_archive_if_not_exist archive_3
      Versionarchive.count.should eq(2)

      archs = Versionarchive.archives( archive.language, archive.prod_key, archive.version_id )
      archs.should_not be_nil
      archs.count.should eq(1)
      archs.first.prod_key.should eql(archive.prod_key)
    end

  end

end
