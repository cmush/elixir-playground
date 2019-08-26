defmodule ElhexDelivery.PostalCode.NavigatorTest do
  use ExUnit.Case
  alias ElhexDelivery.PostalCode.Navigator
  doctest ElhexDelivery

  describe "get_distance" do
    test "postal code strings" do
      distance = Navigator.get_distance("94062", "94104")
      assert is_float(distance)
    end

    test "postal code integers" do
      distance = Navigator.get_distance(94062, 94104)
      assert is_float(distance)
    end

    test "postal code string and integers" do
      distance = Navigator.get_distance("94062", 94104)
      assert is_float(distance)
    end

    # @tag :capture_log
    # test "postal code unexpected format" do
    #   navigator_pid = Process.whereis(:postal_code_navigator)
    #   reference = Process.monitor(navigator_pid)
    #   catch_exit do
    #     Navigator.get_distance("94062", 94014.9876)
    #   end
    #   assert_received({:DOWN, ^reference, :process, ^navigator_pid, {%ArgumentError{}, _}})
    # end
  end

  describe "get_distance (actual distance" do
    test "distance_between_rwc_and_sf" do
      # Redwood City, RWC 95062
      # San Francisco, SF 94104
      # Driving Distance ~ 40 Miles
      distance = Navigator.get_distance(94062, 94104)
      assert distance == 26.75
    end

    test "distance_between_sf_and_nyc" do
      # Redwood City, RWC 94062
      # New York City, NY 10112
      # Driving Distance ~ 3100 miles
      distance = Navigator.get_distance(94062, 10112)
      assert distance == 2568.88
    end

    test "distance_between_mnlps_and_austin" do
      # Minneapolis, MN 55401
      # Austin, TX 78703
      # Driving Distance ~ 1100 miles
      distance = Navigator.get_distance(55401, 78703)
      assert distance == 1044.08
    end
  end
end
