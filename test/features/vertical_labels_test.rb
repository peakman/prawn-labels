require_relative '../test_helper'

describe "Vertical test" do
  let(:pdf_path) { "test/pdfs/vertical_labels.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "can be set for the whole document via type" do
    names  = ["Jordan", "Chris", "Jon", "Mike"]

    Prawn::Labels.types["Avery5160"]["vertical_text"] = true

    Prawn::Labels.generate(pdf_path, names,
                           :type => "Avery5160") do |pdf, name|
      pdf.stroke_bounds
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end
end

describe "Vertical test with offset" do
  let(:pdf_path) { "test/pdfs/vertical_labels_with_offset.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }


  it "works when an offset is specified" do
    names  = ["Jordan", "Chris", "Jon", "Mike"]
    offset_x = 20
    offset_y = 50

    Prawn::Labels.types["Avery5160"]["vertical_text"] = true

    Prawn::Labels.generate(pdf_path, names,
                           :type => "Avery5160") do |pdf, name|
      pdf.stroke_bounds
      
      x, y = pdf.bounds.top_left

      # Add an offset to every label
      pdf.bounding_box([x + offset_x, y - offset_y],
                       width:  pdf.bounds.width - offset_x,
                       height: pdf.bounds.height - offset_y) do
        pdf.text name
      end
    end

    File.exists?(pdf_path).must_equal true
  end
end
