module Dm
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Update Data Model"
      def install
        dm_pairs
      end
      private
      def dm_pairs
				pairs=[
				  ["disease","symptom",1],        
				  ["part","symptom"],
				  ["feel","symptom"],
          ["patient","symptom",1],
          ["patient","disease",1]
				]
        pairs.each do |p|
          if p.size <3
            one_many(p[0],p[1])
          else
            many_many(p[0],p[1])   
          end       
        end
      end

      def one_many(parent,child)
        children=child.pluralize
        parents=parent.pluralize
        pfile="app/models/#{parent}.rb"
        cfile="app/models/#{child}.rb"
     
        pstr ="  has_many :#{children}"  
        pstr +="\n  accepts_nested_attributes_for :#{children} ,:allow_destroy => true\n"            
        
        cstr="  belongs_to :#{parent}\n"

        inject_into_file pfile, pstr, :before => "end"
        inject_into_file cfile, cstr, :before => "end"
      end
      def many_many(parent,child)
        children=child.pluralize
        parents=parent.pluralize
        pfile="app/models/#{parent}.rb"
        cfile="app/models/#{child}.rb"
        mfile="app/models/#{parent}_#{child}.rb"

        through="#{parent}_#{children}"   

        pstr  ="  has_many :#{children}"
        pstr +=",:through=> :#{through}\n"  
        pstr +="  has_many :#{through}\n"            
        pstr +="\n  accepts_nested_attributes_for :#{children} ,:allow_destroy => true\n"            
        
        cstr  ="  has_many :#{parents}" 
        cstr +=",:through=> :#{through}\n"          
        cstr +="  has_many :#{through}\n"           
        cstr +="\n  accepts_nested_attributes_for :#{parents} ,:allow_destroy => true\n"            
        
        mstr  ="  belongs_to :#{parent}\n"
        mstr +="  belongs_to :#{child}\n"        

        inject_into_file pfile,pstr,:before => "end"
        inject_into_file cfile,cstr,:before => "end"        
        inject_into_file mfile,mstr,:before => "end"    

      end
    end
  end
end