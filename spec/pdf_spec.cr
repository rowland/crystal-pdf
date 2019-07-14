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

    context "getting and setting units" do
      it "should get and set units" do
        w = Writer.new
        w.set_units("in")
        w.units.should eq "in"
        w.close
      end

      it "should translate between units" do
        w = Writer.new
        w.set_units("in")
        w.move_to(2, 1)
        w.set_units("pt")
        w.x.should eq 144
        w.y.should eq 72
        w.set_units("dp")
        w.x.should be_close 2000.0, 0.001
        w.y.should be_close 1000.0, 0.001
        w.move_to(3000, 4000)
        w.set_units("pt")
        w.x.should be_close(3 * 72, 0.001)
        w.y.should be_close(4 * 72, 0.001)
        w.close
      end
    end

    context "moves and lines in alternate units" do
      filename = "test_moves_and_lines_units.pdf"
      points = [
        {1.0, 1.0},
        {2.0, 1.0},
        {2.0, 2.0},
        {1.0, 2.0},
      ]
      it "should move to positions and draw lines" do
        w = Writer.new(filename)
        w.set_units("in")
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
