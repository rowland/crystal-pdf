require "./spec_helper"

describe PDF do
  describe PDF::Writer do
    it "should work" do
      PDF::Writer.new
    end

    context "in-memory" do
      it "should return an empty document without a fuss" do
        PDF::Writer.new.to_s.should match /%PDF-1.7/
      end

      it "should return consistent results" do
        w = PDF::Writer.new
        w.to_s.should eq w.to_s
      end
    end

    context "on-disk" do
      it "should create an empty document without a fuss" do
        filename = File.tempname("test", ".pdf")
        PDF::Writer.new(filename).close
        File.read(filename).should match /%PDF-1.7/
      end
    end

    context "moves and lines" do
      filename = "test_moves_and_lines.pdf"
      it "should move to positions and draw lines" do
        w = PDF::Writer.new(filename)
        w.move_to(72, 72)
        w.line_to(144, 72)
        w.close
      end
    end
  end
end
