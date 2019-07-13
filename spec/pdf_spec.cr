require "./spec_helper"

module PDF
  describe Writer do
    it "should work" do
      Writer.new
    end

    context "in-memory" do
      it "should return an empty document without a fuss" do
        Writer.new.to_s.should match /%PDF-1.7/
      end

      it "should return consistent results" do
        w = Writer.new
        w.to_s.should eq w.to_s
      end
    end

    context "on-disk" do
      it "should create an empty document without a fuss" do
        filename = File.tempname("test", ".pdf")
        Writer.new(filename).close
        File.read(filename).should match /%PDF-1.7/
      end
    end

    context "moves and lines" do
      filename = "test_moves_and_lines.pdf"
      points = [
        {72.0, 72.0},
        {144.0, 72.0},
        {144.0, 144.0},
        {72.0, 144.0},
      ]
      it "should move to positions and draw lines" do
        w = Writer.new(filename)
        points.each_with_index do |p, i|
          if i == 0
            w.move_to(p)
          else
            w.line_to(p)
          end
        end
        w.close
      end
    end
  end
end
