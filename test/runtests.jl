using TestItems
using TestItemRunner

@run_package_tests

@testsnippet Setup begin
  using Meshes
  using CoordRefSystems
  using ReferenceTests
  using Distributions
  using Colors
  using StableRNGs
  using Random

  import CairoMakie as Mke

  datadir = joinpath(@__DIR__, "data")

  cart(x...) = Point(x...)
  latlon(x...) = Point(LatLon(x...))
end

@testitem "Point" setup = [Setup] begin
  rng = StableRNG(123)

  # 2D Point (Cartesian)
  p = rand(rng, Point, 10, crs=Cartesian2D)
  @test_reference joinpath(datadir, "point-euclid2D-1.png") viz(p)
  @test_reference joinpath(datadir, "point-euclid2D-2.png") viz(p, color="red")
  @test_reference joinpath(datadir, "point-euclid2D-3.png") viz(p, color=1:10)
  @test_reference joinpath(datadir, "point-euclid2D-4.png") viz(p, color=1:10, pointsize=20)

  # 2D Point (LatLon)
  p = rand(rng, Point, 10, crs=LatLon)
  @test_reference joinpath(datadir, "point-globe-1.png") viz(p)
  @test_reference joinpath(datadir, "point-globe-2.png") viz(p, color="red")
  @test_reference joinpath(datadir, "point-globe-3.png") viz(p, color=1:10)
  @test_reference joinpath(datadir, "point-globe-4.png") viz(p, color=1:10, pointsize=20)

  # 3D Point (Cartesian)
  p = rand(rng, Point, 10, crs=Cartesian3D)
  @test_reference joinpath(datadir, "point-euclid3D-1.png") viz(p)
  @test_reference joinpath(datadir, "point-euclid3D-2.png") viz(p, color="red")
  @test_reference joinpath(datadir, "point-euclid3D-3.png") viz(p, color=1:10)
  @test_reference joinpath(datadir, "point-euclid3D-4.png") viz(p, color=1:10, pointsize=20)
end

@testitem "Ray/Vec" setup = [Setup] begin
  rng = StableRNG(123)

  # 2D Ray (Cartesian)
  r = rand(rng, Ray, 10, crs=Cartesian2D)
  @test_reference joinpath(datadir, "ray-euclid2D-1.png") viz(r)
  @test_reference joinpath(datadir, "ray-euclid2D-2.png") viz(r, color="red")
  @test_reference joinpath(datadir, "ray-euclid2D-3.png") viz(r, color=1:10)
  @test_reference joinpath(datadir, "ray-euclid2D-4.png") viz(r, color=1:10, segmentsize=10)

  # 3D Ray (Cartesian)
  r = rand(rng, Ray, 10, crs=Cartesian3D)
  @test_reference joinpath(datadir, "ray-euclid3D-1.png") viz(r)
  @test_reference joinpath(datadir, "ray-euclid3D-2.png") viz(r, color="red")
  @test_reference joinpath(datadir, "ray-euclid3D-3.png") viz(r, color=1:10)
  @test_reference joinpath(datadir, "ray-euclid3D-4.png") viz(r, color=1:10, segmentsize=10)

  # 2D Vec (Cartesian)
  v = [Vec(cos(t), sin(t)) for t in range(0, 2π, length=10)]
  @test_reference joinpath(datadir, "vec-euclid2D-1.png") viz(v)
  @test_reference joinpath(datadir, "vec-euclid2D-2.png") viz(v, color="red")
  @test_reference joinpath(datadir, "vec-euclid2D-3.png") viz(v, color=1:10)
  @test_reference joinpath(datadir, "vec-euclid2D-4.png") viz(v, color=1:10, segmentsize=10)

  # 3D Vec (Cartesian)
  v = [Vec(cos(t), sin(t), 0) for t in range(0, 2π, length=10)]
  @test_reference joinpath(datadir, "vec-euclid3D-1.png") viz(v)
  @test_reference joinpath(datadir, "vec-euclid3D-2.png") viz(v, color="red")
  @test_reference joinpath(datadir, "vec-euclid3D-3.png") viz(v, color=1:10)
  @test_reference joinpath(datadir, "vec-euclid3D-4.png") viz(v, color=1:10, segmentsize=10)
end

@testitem "Curve" setup = [Setup] begin
  # 2D Bezier (Cartesian)
  b = BezierCurve(cart(0, 0), cart(10, 0), cart(10, 10))
  @test_reference joinpath(datadir, "bezier-euclid2D-1.png") viz(b)
  @test_reference joinpath(datadir, "bezier-euclid2D-2.png") viz(b, color="red")
  @test_reference joinpath(datadir, "bezier-euclid2D-3.png") viz(b, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "bezier-euclid2D-4.png") viz(b, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 2D Bezier (LatLon)
  b = BezierCurve(latlon(0, 0), latlon(0, 10), latlon(10, 10))
  @test_reference joinpath(datadir, "bezier-globe-1.png") viz(b)
  @test_reference joinpath(datadir, "bezier-globe-2.png") viz(b, color="red")
  @test_reference joinpath(datadir, "bezier-globe-3.png") viz(b, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "bezier-globe-4.png") viz(b, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 3D Bezier (Cartesian)
  b = BezierCurve(cart(0, 0, 0), cart(10, 0, 0), cart(10, 20, 10))
  @test_reference joinpath(datadir, "bezier-euclid3D-1.png") viz(b)
  @test_reference joinpath(datadir, "bezier-euclid3D-2.png") viz(b, color="red")
  @test_reference joinpath(datadir, "bezier-euclid3D-3.png") viz(b, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "bezier-euclid3D-4.png") viz(b, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 2D ParametrizedCurve (Cartesian)
  c = ParametrizedCurve(t -> Point(cospi(2t), sinpi(2t)))
  @test_reference joinpath(datadir, "curve-euclid2D-1.png") viz(c)
  @test_reference joinpath(datadir, "curve-euclid2D-2.png") viz(c, color="red")
  @test_reference joinpath(datadir, "curve-euclid2D-3.png") viz(c, color="red", segmentsize=10)

  # 3D ParametrizedCurve (Cartesian)
  c = ParametrizedCurve(t -> Point(cos(t), sin(t), 0.2t), (0, 4π))
  @test_reference joinpath(datadir, "curve-euclid3D-1.png") viz(c)
  @test_reference joinpath(datadir, "curve-euclid3D-2.png") viz(c, color="red")
  @test_reference joinpath(datadir, "curve-euclid3D-3.png") viz(c, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "curve-euclid3D-4.png") viz(c, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")
end

@testitem "Line" setup = [Setup] begin
  # 2D Line (Cartesian)
  l = [Line((0, 0), (1, 0)), Line((0, 0), (1, 1)), Line((0, 0), (0, 1))]
  @test_reference joinpath(datadir, "line-euclid2D-1.png") viz(l)
  @test_reference joinpath(datadir, "line-euclid2D-2.png") viz(l, color="red")
  @test_reference joinpath(datadir, "line-euclid2D-3.png") viz(l, color=1:3)
  @test_reference joinpath(datadir, "line-euclid2D-4.png") viz(l, color=1:3, segmentsize=10)
end

@testitem "Box" setup = [Setup] begin
  # 2D Box (Cartesian)
  b = Box(cart(0, 0), cart(10, 10))
  @test_reference joinpath(datadir, "box-euclid2D-1.png") viz(b)
  @test_reference joinpath(datadir, "box-euclid2D-2.png") viz(b, color="red")
  @test_reference joinpath(datadir, "box-euclid2D-3.png") viz(b, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "box-euclid2D-4.png") viz(b, color="red", showsegments=true)
  @test_reference joinpath(datadir, "box-euclid2D-5.png") viz(b, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "box-euclid2D-6.png") viz(b, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D Box (LatLon)
  b = Box(latlon(0, 0), latlon(10, 10))
  @test_reference joinpath(datadir, "box-globe-1.png") viz(b)
  @test_reference joinpath(datadir, "box-globe-2.png") viz(b, color="red")
  @test_reference joinpath(datadir, "box-globe-3.png") viz(b, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "box-globe-4.png") viz(b, color="red", showsegments=true)
  @test_reference joinpath(datadir, "box-globe-5.png") viz(b, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "box-globe-6.png") viz(b, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 3D Box (Cartesian)
  b = Box(cart(0, 0, 0), cart(10, 10, 10))
  @test_reference joinpath(datadir, "box-euclid3D-1.png") viz(b)
  @test_reference joinpath(datadir, "box-euclid3D-2.png") viz(b, color="red")
  @test_reference joinpath(datadir, "box-euclid3D-3.png") viz(b, color="red", alpha=0.5)
end

@testitem "Ball/Sphere" setup = [Setup] begin
  # 2D balls
  b = Ball((0.0, 0.0), 1.0)
  @test_reference joinpath(datadir, "ball2D-1.png") viz(b)
  @test_reference joinpath(datadir, "ball2D-2.png") viz(b, showsegments=true)
  @test_reference joinpath(datadir, "ball2D-3.png") viz(b, color="red")
  @test_reference joinpath(datadir, "ball2D-4.png") viz(b, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "ball2D-5.png") viz(b, color="red", alpha=0.5)

  # 2D spheres
  s = Sphere((0.0, 0.0), 1.0)
  @test_reference joinpath(datadir, "sphere2D-1.png") viz(s)
  @test_reference joinpath(datadir, "sphere2D-2.png") viz(s, color="red")
  @test_reference joinpath(datadir, "sphere2D-3.png") viz(s, color="red", alpha=0.5)

  # 3D spheres
  s = Sphere((0.0, 0.0, 0.0), 1.0)
  @test_reference joinpath(datadir, "sphere3D-1.png") viz(s)
  @test_reference joinpath(datadir, "sphere3D-2.png") viz(s, color="red")
  @test_reference joinpath(datadir, "sphere3D-3.png") viz(s, color="red", alpha=0.5)
end

@testitem "Cylinder/CylinderSurface" setup = [Setup] begin
  # Cylinder (vertical)
  c = Cylinder(1.0)
  @test_reference joinpath(datadir, "cylinder3D-1.png") viz(c)
  @test_reference joinpath(datadir, "cylinder3D-2.png") viz(c, color="red")
  @test_reference joinpath(datadir, "cylinder3D-3.png") viz(c, color="red", alpha=0.5)

  # Cylinder (diagonal)
  c = Cylinder((1.0, 0.0, 0.0), (1.0, 1.0, 1.0), 1.0)
  @test_reference joinpath(datadir, "cylinder3D-4.png") viz(c)
  @test_reference joinpath(datadir, "cylinder3D-5.png") viz(c, color="red")
  @test_reference joinpath(datadir, "cylinder3D-6.png") viz(c, color="red", alpha=0.5)

  # CylinderSurface (diagonal)
  c = CylinderSurface((1.0, 0.0, 0.0), (1.0, 1.0, 1.0), 1.0)
  @test_reference joinpath(datadir, "cylsurf3D-1.png") viz(c)
  @test_reference joinpath(datadir, "cylsurf3D-2.png") viz(c, color="red")
  @test_reference joinpath(datadir, "cylsurf3D-3.png") viz(c, color="red", alpha=0.5)
end

@testitem "Chain" setup = [Setup] begin
  # 2D Segment (Cartesian)
  s = Segment(cart(0, 0), cart(10, 10))
  @test_reference joinpath(datadir, "seg-euclid2D-1.png") viz(s)
  @test_reference joinpath(datadir, "seg-euclid2D-2.png") viz(s, color="red")
  @test_reference joinpath(datadir, "seg-euclid2D-3.png") viz(s, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "seg-euclid2D-4.png") viz(s, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 2D Segment (LatLon)
  s = Segment(latlon(0, 0), latlon(10, 10))
  @test_reference joinpath(datadir, "seg-globe-1.png") viz(s)
  @test_reference joinpath(datadir, "seg-globe-2.png") viz(s, color="red")
  @test_reference joinpath(datadir, "seg-globe-3.png") viz(s, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "seg-globe-4.png") viz(s, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 2D Rope (Cartesian)
  r = Rope(cart(0, 0), cart(10, 5), cart(10, 10), cart(20, 0))
  @test_reference joinpath(datadir, "rope-euclid2D-1.png") viz(r)
  @test_reference joinpath(datadir, "rope-euclid2D-2.png") viz(r, color="red")
  @test_reference joinpath(datadir, "rope-euclid2D-3.png") viz(r, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "rope-euclid2D-4.png") viz(r, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 2D Rope (LatLon)
  r = Rope(latlon(0, 0), latlon(5, 10), latlon(10, 10), latlon(0, 20))
  @test_reference joinpath(datadir, "rope-globe-1.png") viz(r)
  @test_reference joinpath(datadir, "rope-globe-2.png") viz(r, color="red")
  @test_reference joinpath(datadir, "rope-globe-3.png") viz(r, color="red", segmentsize=10)
  @test_reference joinpath(datadir, "rope-globe-4.png") viz(r, color="red", segmentsize=10, showpoints=true, pointsize=20, pointcolor="cyan")

  # 2D Ring (Cartesian)
  r = Ring(cart(0, 0), cart(10, 5), cart(10, 10), cart(20, 0))
  @test_reference joinpath(datadir, "ring-euclid2D-1.png") viz(r)
  @test_reference joinpath(datadir, "ring-euclid2D-2.png") viz(r, color="red")
  @test_reference joinpath(datadir, "ring-euclid2D-3.png") viz(r, color="red", segmentsize=10)

  # 2D Ring (LatLon)
  r = Ring(latlon(0, 0), latlon(5, 10), latlon(10, 10), latlon(0, 20))
  @test_reference joinpath(datadir, "ring-globe-1.png") viz(r)
  @test_reference joinpath(datadir, "ring-globe-2.png") viz(r, color="red")
  @test_reference joinpath(datadir, "ring-globe-3.png") viz(r, color="red", segmentsize=10)
end

@testitem "Polygon" setup = [Setup] begin
  # 2D Triangle (Cartesian)
  t = Triangle(cart(0, 0), cart(10, 0), cart(0, 10))
  @test_reference joinpath(datadir, "tri-euclid2D-1.png") viz(t)
  @test_reference joinpath(datadir, "tri-euclid2D-2.png") viz(t, color="red")
  @test_reference joinpath(datadir, "tri-euclid2D-3.png") viz(t, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "tri-euclid2D-4.png") viz(t, color="red", showsegments=true)
  @test_reference joinpath(datadir, "tri-euclid2D-5.png") viz(t, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "tri-euclid2D-6.png") viz(t, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D Triangle (LatLon)
  t = Triangle(latlon(0, 0), latlon(0, 10), latlon(10, 0))
  @test_reference joinpath(datadir, "tri-globe-1.png") viz(t)
  @test_reference joinpath(datadir, "tri-globe-2.png") viz(t, color="red")
  @test_reference joinpath(datadir, "tri-globe-3.png") viz(t, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "tri-globe-4.png") viz(t, color="red", showsegments=true)
  @test_reference joinpath(datadir, "tri-globe-5.png") viz(t, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "tri-globe-6.png") viz(t, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D Quadrangle (Cartesian)
  q = Quadrangle(cart(0, 0), cart(10, 0), cart(10, 10), cart(0, 10))
  @test_reference joinpath(datadir, "quad-euclid2D-1.png") viz(q)
  @test_reference joinpath(datadir, "quad-euclid2D-2.png") viz(q, color="red")
  @test_reference joinpath(datadir, "quad-euclid2D-3.png") viz(q, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "quad-euclid2D-4.png") viz(q, color="red", showsegments=true)
  @test_reference joinpath(datadir, "quad-euclid2D-5.png") viz(q, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "quad-euclid2D-6.png") viz(q, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D Quadrangle (LatLon)
  q = Quadrangle(latlon(0, 0), latlon(0, 10), latlon(10, 10), latlon(10, 0))
  @test_reference joinpath(datadir, "quad-globe-1.png") viz(q)
  @test_reference joinpath(datadir, "quad-globe-2.png") viz(q, color="red")
  @test_reference joinpath(datadir, "quad-globe-3.png") viz(q, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "quad-globe-4.png") viz(q, color="red", showsegments=true)
  @test_reference joinpath(datadir, "quad-globe-5.png") viz(q, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "quad-globe-6.png") viz(q, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D PolyArea (Cartesian)
  o = [cart(0, 0), cart(10, 0), cart(10, 10), cart(0, 10)]
  i1 = [cart(2, 2), cart(2, 4), cart(4, 4), cart(4, 2)]
  i2 = [cart(6, 2), cart(6, 4), cart(8, 4), cart(8, 2)]
  p = PolyArea([o, i1, i2])
  @test_reference joinpath(datadir, "poly-euclid2D-1.png") viz(p)
  @test_reference joinpath(datadir, "poly-euclid2D-2.png") viz(p, color="red")
  @test_reference joinpath(datadir, "poly-euclid2D-3.png") viz(p, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "poly-euclid2D-4.png") viz(p, color="red", showsegments=true)
  @test_reference joinpath(datadir, "poly-euclid2D-5.png") viz(p, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "poly-euclid2D-6.png") viz(p, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D PolyArea (LatLon)
  o = [latlon(0, 0), latlon(0, 10), latlon(10, 10), latlon(10, 0)]
  i1 = [latlon(2, 2), latlon(4, 2), latlon(4, 4), latlon(2, 4)]
  i2 = [latlon(2, 6), latlon(4, 6), latlon(4, 8), latlon(2, 8)]
  p = PolyArea([o, i1, i2])
  @test_reference joinpath(datadir, "poly-globe-1.png") viz(p)
  @test_reference joinpath(datadir, "poly-globe-2.png") viz(p, color="red")
  @test_reference joinpath(datadir, "poly-globe-3.png") viz(p, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "poly-globe-4.png") viz(p, color="red", showsegments=true)
  @test_reference joinpath(datadir, "poly-globe-5.png") viz(p, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "poly-globe-6.png") viz(p, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 3D Octagon (Cartesian)
  o = Octagon(
    cart(0.0, 0.0, 1.0),
    cart(0.5, -0.5, 0.0),
    cart(1.0, 0.0, 0.0),
    cart(1.5, 0.5, -0.5),
    cart(1.0, 1.0, 0.0),
    cart(0.5, 1.5, 0.0),
    cart(0.0, 1.0, 0.0),
    cart(-0.5, 0.5, 0.0)
  )
  @test_reference joinpath(datadir, "oct-euclid3D-1.png") viz(o)
  @test_reference joinpath(datadir, "oct-euclid3D-2.png") viz(o, color="red")
  @test_reference joinpath(datadir, "oct-euclid3D-3.png") viz(o, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "oct-euclid3D-4.png") viz(o, color="red", showsegments=true)
  @test_reference joinpath(datadir, "oct-euclid3D-5.png") viz(o, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "oct-euclid3D-6.png") viz(o, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)
end

@testitem "Multi" setup = [Setup] begin
  # 2D Multi-Ngon (Cartesian)
  t = Triangle(cart(-10, 0), cart(0, 0), cart(-10, 10))
  q = Quadrangle(cart(0, 0), cart(10, 0), cart(10, 10), cart(0, 10))
  m = Multi([t, q])
  @test_reference joinpath(datadir, "multi-euclid2D-1.png") viz(m)
  @test_reference joinpath(datadir, "multi-euclid2D-2.png") viz(m, color="red")
  @test_reference joinpath(datadir, "multi-euclid2D-3.png") viz(m, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "multi-euclid2D-4.png") viz(m, color="red", showsegments=true)
  @test_reference joinpath(datadir, "multi-euclid2D-5.png") viz(m, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "multi-euclid2D-6.png") viz(m, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D Multi-Ngon (LatLon)
  t = Triangle(latlon(0, -10), latlon(0, 0), latlon(10, -10))
  q = Quadrangle(latlon(0, 0), latlon(0, 10), latlon(10, 10), latlon(10, 0))
  m = Multi([t, q])
  @test_reference joinpath(datadir, "multi-globe-1.png") viz(m)
  @test_reference joinpath(datadir, "multi-globe-2.png") viz(m, color="red")
  @test_reference joinpath(datadir, "multi-globe-3.png") viz(m, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "multi-globe-4.png") viz(m, color="red", showsegments=true)
  @test_reference joinpath(datadir, "multi-globe-5.png") viz(m, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "multi-globe-6.png") viz(m, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)
end

@testitem "Transformed" setup = [Setup] begin
  # 2D Transformed-Box (Cartesian)
  b = Box(cart(0, 0), cart(10, 10))
  t = TransformedGeometry(b, Proj(Mercator))
  @test_reference joinpath(datadir, "transf-euclid2D-1.png") viz(t)
  @test_reference joinpath(datadir, "transf-euclid2D-2.png") viz(t, color="red")
  @test_reference joinpath(datadir, "transf-euclid2D-3.png") viz(t, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "transf-euclid2D-4.png") viz(t, color="red", showsegments=true)
  @test_reference joinpath(datadir, "transf-euclid2D-5.png") viz(t, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "transf-euclid2D-6.png") viz(t, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)

  # 2D Transformed-Box (LatLon)
  b = Box(latlon(0, 0), latlon(10, 10))
  t = TransformedGeometry(b, Proj(Mercator))
  @test_reference joinpath(datadir, "transf-globe-1.png") viz(t)
  @test_reference joinpath(datadir, "transf-globe-2.png") viz(t, color="red")
  @test_reference joinpath(datadir, "transf-globe-3.png") viz(t, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "transf-globe-4.png") viz(t, color="red", showsegments=true)
  @test_reference joinpath(datadir, "transf-globe-5.png") viz(t, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "transf-globe-6.png") viz(t, color="red", showsegments=true, segmentcolor="cyan", segmentsize=10)
end

@testitem "GeometrySet" setup = [Setup] begin
  # 1D geometries
  g1 = Rope((0.0, 0.0), (1.0, 1.0), (0.0, 1.0))
  g2 = Rope((1.0, 1.0), (2.0, 2.0), (1.0, 2.0))
  g = GeometrySet([g1, g2])
  @test_reference joinpath(datadir, "geomset1D-1.png") viz(g)
  @test_reference joinpath(datadir, "geomset1D-2.png") viz(g, color=1:2)
  @test_reference joinpath(datadir, "geomset1D-3.png") viz(g, color=1:2, colormap="inferno")
  @test_reference joinpath(datadir, "geomset1D-4.png") viz(g, color=["red", "green"], alpha=0.5)
  @test_reference joinpath(datadir, "geomset1D-5.png") viz(g, color=1:2, alpha=0.5)

  # 2D geometries
  t = Triangle((1.0, 0.0), (2.0, 0.0), (2.0, 1.0))
  q = Quadrangle((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0))
  g = GeometrySet([t, q])
  @test_reference joinpath(datadir, "geomset2D-1.png") viz(g)
  @test_reference joinpath(datadir, "geomset2D-2.png") viz(g, showsegments=true)
  @test_reference joinpath(datadir, "geomset2D-3.png") viz(g, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "geomset2D-4.png") viz(g, color=1:2)
  @test_reference joinpath(datadir, "geomset2D-5.png") viz(g, color=1:2, colormap="inferno")
  @test_reference joinpath(datadir, "geomset2D-6.png") viz(g, color=["red", "green"], alpha=0.5)
  @test_reference joinpath(datadir, "geomset2D-7.png") viz(g, color=1:2, alpha=0.5)

  # 3D multi-geometries
  b1 = Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))
  b2 = Box((2.0, 1.0, 0.0), (3.0, 2.0, 1.0))
  s1 = Ball((3.0, 0.0, 3.0), 1.0)
  s2 = Ball((-1.0, 0.0, -1.0), 1.0)
  m1 = Multi([b1, b2])
  m2 = Multi([s1, s2])
  g = GeometrySet([m1, m2])
  @test_reference joinpath(datadir, "geomset3D-1.png") viz(g)
  @test_reference joinpath(datadir, "geomset3D-2.png") viz(g, color=1:2)
  @test_reference joinpath(datadir, "geomset3D-3.png") viz(g, color=1:2, colormap="inferno")
  @test_reference joinpath(datadir, "geomset3D-4.png") viz(g, color=["red", "green"], alpha=0.5)
  @test_reference joinpath(datadir, "geomset3D-5.png") viz(g, color=1:2, alpha=0.5)

  # 3D multi-geometries with segments
  q = rand(Quadrangle, 2)
  p = rand(Triangle, 2)
  g = GeometrySet([Multi(p),Multi(q)])
  viz(g)
  viz(g, showsegments=true)
  viz(g, color=1:2, colormap="inferno")
  viz(g, color=1:2, colormap="inferno", showsegments=true, segmentcolor="red")
  viz(g, color=["red", "green"], alpha=0.5)
  viz(g, color=["red", "green"], alpha=0.5, showsegments=true, segmentcolor="red")

  # 3D multi-geometries with segments and points
  r = rand(Ray, 5)
  p = rand(Triangle, 5)
  g = GeometrySet([Multi(p),Multi(r)])
  viz(g)
  viz(g, showpoints=true, pointsize=20, showsegments=true)
  viz(g, showpoints=true, pointsize=20, pointcolor="red", showsegments=true, segmentcolor="red")
  viz(g, color=1:2)
  viz(g, color=1:2, colormap="inferno")
  viz(g, color=["red", "green"], alpha=0.5)
  viz(g, color=1:2, alpha=0.5)
end

@testitem "Grid" setup = [Setup] begin
  # 2D CartesianGrid
  g = CartesianGrid(10, 10)
  ne = nelements(g)
  @test_reference joinpath(datadir, "cartgrid2D-1.png") viz(g)
  @test_reference joinpath(datadir, "cartgrid2D-2.png") viz(g, showsegments=true)
  @test_reference joinpath(datadir, "cartgrid2D-3.png") viz(g, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "cartgrid2D-4.png") viz(g, color=1:ne)
  @test_reference joinpath(datadir, "cartgrid2D-5.png") viz(g, color=1:ne, colormap="inferno")
  @test_reference joinpath(datadir, "cartgrid2D-6.png") viz(g, color="red")
  @test_reference joinpath(datadir, "cartgrid2D-7.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "cartgrid2D-8.png") viz(g, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "cartgrid2D-9.png") viz(g, color=1:ne, showsegments=true)
  @test_reference joinpath(datadir, "cartgrid2D-10.png") viz(g, color=1:ne, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "cartgrid2D-11.png") viz(g, showsegments=true, segmentsize=5)
  @test_reference joinpath(datadir, "cartgrid2D-12.png") viz(g, showsegments=true, segmentcolor="red", segmentsize=5)

  # 3D CartesianGrid
  g = CartesianGrid(10, 10, 10)
  nv = nvertices(g)
  ne = nelements(g)
  @test_reference joinpath(datadir, "cartgrid3D-1.png") viz(g)
  @test_reference joinpath(datadir, "cartgrid3D-2.png") viz(g, showsegments=true)
  @test_reference joinpath(datadir, "cartgrid3D-3.png") viz(g, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "cartgrid3D-4.png") viz(g, color=1:ne)
  @test_reference joinpath(datadir, "cartgrid3D-5.png") viz(g, color=1:ne, colormap="inferno")
  @test_reference joinpath(datadir, "cartgrid3D-6.png") viz(g, color="red")
  @test_reference joinpath(datadir, "cartgrid3D-7.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "cartgrid3D-8.png") viz(g, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "cartgrid3D-9.png") viz(g, color=1:ne, showsegments=true)
  @test_reference joinpath(datadir, "cartgrid3D-10.png") viz(g, color=1:ne, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "cartgrid3D-11.png") viz(g, showsegments=true, segmentsize=5)
  @test_reference joinpath(datadir, "cartgrid3D-12.png") viz(g, showsegments=true, segmentcolor="red", segmentsize=5)
  @test_reference joinpath(datadir, "cartgrid3D-13.png") viz(g, color=1:nv)
  @test_reference joinpath(datadir, "cartgrid3D-14.png") viz(g, color=1:nv, colormap="inferno")
  @test_reference joinpath(datadir, "cartgrid3D-15.png") viz(g, color=1:nv, alpha=0.5)
  @test_reference joinpath(datadir, "cartgrid3D-16.png") viz(g, color=1:nv, showsegments=true)
  @test_reference joinpath(datadir, "cartgrid3D-17.png") viz(g, color=1:nv, showsegments=true, segmentcolor="red")

  # 2D RectilinearGrid
  x = 0:0.2:1
  y = [0.0, 0.1, 0.3, 0.7, 0.9, 1.0]
  g = RectilinearGrid(x, y)
  ne = nelements(g)
  @test_reference joinpath(datadir, "rectgrid2D-1.png") viz(g)
  @test_reference joinpath(datadir, "rectgrid2D-2.png") viz(g, showsegments=true)
  @test_reference joinpath(datadir, "rectgrid2D-3.png") viz(g, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "rectgrid2D-4.png") viz(g, color=1:ne)
  @test_reference joinpath(datadir, "rectgrid2D-5.png") viz(g, color=1:ne, colormap="inferno")
  @test_reference joinpath(datadir, "rectgrid2D-6.png") viz(g, color="red")
  @test_reference joinpath(datadir, "rectgrid2D-7.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "rectgrid2D-8.png") viz(g, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "rectgrid2D-9.png") viz(g, color=1:ne, showsegments=true)
  @test_reference joinpath(datadir, "rectgrid2D-10.png") viz(g, color=1:ne, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "rectgrid2D-11.png") viz(g, showsegments=true, segmentsize=5)
  @test_reference joinpath(datadir, "rectgrid2D-12.png") viz(g, showsegments=true, segmentcolor="red", segmentsize=5)

  # 2D StructuredGrid
  X = [i / 20 * cos(3π / 2 * (j - 1) / (30 - 1)) for i in 1:20, j in 1:30]
  Y = [i / 20 * sin(3π / 2 * (j - 1) / (30 - 1)) for i in 1:20, j in 1:30]
  g = StructuredGrid(X, Y)
  ne = nelements(g)
  @test_reference joinpath(datadir, "structgrid2D-1.png") viz(g)
  @test_reference joinpath(datadir, "structgrid2D-2.png") viz(g, showsegments=true)
  @test_reference joinpath(datadir, "structgrid2D-3.png") viz(g, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "structgrid2D-4.png") viz(g, color=1:ne)
  @test_reference joinpath(datadir, "structgrid2D-5.png") viz(g, color=1:ne, colormap="inferno")
  @test_reference joinpath(datadir, "structgrid2D-6.png") viz(g, color="red")
  @test_reference joinpath(datadir, "structgrid2D-7.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "structgrid2D-8.png") viz(g, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "structgrid2D-9.png") viz(g, color=1:ne, showsegments=true)
  @test_reference joinpath(datadir, "structgrid2D-10.png") viz(g, color=1:ne, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "structgrid2D-11.png") viz(g, showsegments=true, segmentsize=5)
  @test_reference joinpath(datadir, "structgrid2D-12.png") viz(g, showsegments=true, segmentcolor="red", segmentsize=5)
end

@testitem "Mesh" setup = [Setup] begin
  # 2D SimpleMesh
  g = CartesianGrid(10, 10)
  m = simplexify(g)
  ne = nelements(m)
  @test_reference joinpath(datadir, "simplemesh2D-1.png") viz(m)
  @test_reference joinpath(datadir, "simplemesh2D-2.png") viz(m, showsegments=true)
  @test_reference joinpath(datadir, "simplemesh2D-3.png") viz(m, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "simplemesh2D-4.png") viz(m, color=1:ne)
  @test_reference joinpath(datadir, "simplemesh2D-5.png") viz(m, color=1:ne, colormap="inferno")
  @test_reference joinpath(datadir, "simplemesh2D-6.png") viz(m, color="red")
  @test_reference joinpath(datadir, "simplemesh2D-7.png") viz(m, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "simplemesh2D-8.png") viz(m, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "simplemesh2D-9.png") viz(m, color=1:ne, showsegments=true)
  @test_reference joinpath(datadir, "simplemesh2D-10.png") viz(m, color=1:ne, showsegments=true, segmentcolor="red")
  @test_reference joinpath(datadir, "simplemesh2D-11.png") viz(m, showsegments=true, segmentsize=5)
  @test_reference joinpath(datadir, "simplemesh2D-12.png") viz(m, showsegments=true, segmentcolor="red", segmentsize=5)

  # 3D SimpleMesh
  g = CartesianGrid(10, 10, 10)
  m = simplexify(g)
  ne = nelements(m)
  @test_reference joinpath(datadir, "simplemesh3D-1.png") viz(m)
  @test_reference joinpath(datadir, "simplemesh3D-2.png") viz(m, color=1:ne)
  @test_reference joinpath(datadir, "simplemesh3D-3.png") viz(m, color=1:ne, colormap="inferno")
  @test_reference joinpath(datadir, "simplemesh3D-4.png") viz(m, color="red")
  @test_reference joinpath(datadir, "simplemesh3D-5.png") viz(m, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "simplemesh3D-6.png") viz(m, color=1:ne, alpha=0.5)
end

@testitem "Surface/Volume" setup = [Setup] begin
  # surface meshes
  s = Sphere((0.0, 0.0, 0.0), 1.0)
  m = discretize(s, RegularDiscretization(10))
  nv = nvertices(m)
  ne = nelements(m)
  @test_reference joinpath(datadir, "surf3D-1.png") viz(m)
  @test_reference joinpath(datadir, "surf3D-2.png") viz(m, color=1:nv)
  @test_reference joinpath(datadir, "surf3D-3.png") viz(m, color=1:ne)
  @test_reference joinpath(datadir, "surf3D-4.png") viz(m, color=1:ne, showsegments=true)
  @test_reference joinpath(datadir, "surf3D-5.png") viz(m, color="red", showsegments=true, segmentcolor="cyan")
  @test_reference joinpath(datadir, "surf3D-6.png") viz(m, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "surf3D-7.png") viz(m, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "surf3D-8.png") viz(m, color=1:ne, alpha=range(0.1, 1.0, length=ne))

  # volume meshes
  g = CartesianGrid(10, 10, 10)
  v = vertices(g)
  e = collect(elements(topology(g)))
  m = SimpleMesh(v, e)
  nv = nvertices(m)
  ne = nelements(m)
  @test_reference joinpath(datadir, "vol3D-1.png") viz(m)
  @test_reference joinpath(datadir, "vol3D-2.png") viz(m, color=1:ne)
  @test_reference joinpath(datadir, "vol3D-3.png") viz(m, color="red")
  @test_reference joinpath(datadir, "vol3D-4.png") viz(m, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "vol3D-5.png") viz(m, color=1:ne, alpha=0.5)
  @test_reference joinpath(datadir, "vol3D-6.png") viz(m, color=1:ne, alpha=range(0.1, 1.0, length=ne))
end

@testitem "Geometries" setup = [Setup] begin
  # vector of 2D geometries
  t = Triangle((1.0, 0.0), (2.0, 0.0), (2.0, 1.0))
  q = Quadrangle((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0))
  g = [t, q]
  @test_reference joinpath(datadir, "geoms2D-1.png") viz(g)
  @test_reference joinpath(datadir, "geoms2D-2.png") viz(g, color=1:2)
  @test_reference joinpath(datadir, "geoms2D-3.png") viz(g, color=1:2, colormap="inferno")
  @test_reference joinpath(datadir, "geoms2D-4.png") viz(g, color="red")
  @test_reference joinpath(datadir, "geoms2D-5.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "geoms2D-6.png") viz(g, color=1:2, alpha=0.5)
  @test_reference joinpath(datadir, "geoms2D-7.png") viz(g, showsegments=true, segmentcolor="cyan")
  # vector of 3D geometries
  c1 = Cylinder((0.0, 0.0, 0.0), (1.0, 1.0, 0.0), 2.0)
  c2 = Cylinder((2.0, 2.0, 0.0), (3.0, 3.0, 0.0), 1.0)
  g = [c1, c2]
  @test_reference joinpath(datadir, "geoms3D-1.png") viz(g)
  @test_reference joinpath(datadir, "geoms3D-2.png") viz(g, color=1:2)
  @test_reference joinpath(datadir, "geoms3D-3.png") viz(g, color=1:2, colormap="inferno")
  @test_reference joinpath(datadir, "geoms3D-4.png") viz(g, color="red")
  @test_reference joinpath(datadir, "geoms3D-5.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "geoms3D-6.png") viz(g, color=1:2, alpha=0.5)

  # vector of 0D, 2D, 3D geometries
  p = Point(2, 2, 0)
  t = Triangle((1, 0, 2), (1, 1, 2), (0, 1, 2))
  h = first(CartesianGrid(1, 1, 1))
  g = [p, t, h]
  @test_reference joinpath(datadir, "geoms-1.png") viz(g)
  @test_reference joinpath(datadir, "geoms-2.png") viz(g, color=1:3)
  @test_reference joinpath(datadir, "geoms-3.png") viz(g, color=1:3, colormap="inferno")
  @test_reference joinpath(datadir, "geoms-4.png") viz(g, color="red")
  @test_reference joinpath(datadir, "geoms-5.png") viz(g, color="red", alpha=0.5)
  @test_reference joinpath(datadir, "geoms-6.png") viz(g, color=1:3, alpha=0.5)
end

@testitem "Views" setup = [Setup] begin
  # views of grids (optimized for performance)
  g = CartesianGrid(10, 10)
  v = view(g, 1:2:100)
  @test_reference joinpath(datadir, "gridview2D-1.png") viz(v)
  @test_reference joinpath(datadir, "gridview2D-2.png") viz(v, color=1:50)
  @test_reference joinpath(datadir, "gridview2D-3.png") viz(v, color=1:50, colormap="inferno")
  g = CartesianGrid(10, 10, 10)
  v = view(g, 1:2:1000)
  @test_reference joinpath(datadir, "gridview3D-1.png") viz(v)
  @test_reference joinpath(datadir, "gridview3D-2.png") viz(v, color=1:500)
  @test_reference joinpath(datadir, "gridview3D-3.png") viz(v, color=1:500, colormap="inferno")

  # views of meshes
  g = CartesianGrid(10, 10)
  m = convert(SimpleMesh, g)
  v = view(m, 1:2:100)
  @test_reference joinpath(datadir, "meshview2D-1.png") viz(v)
  @test_reference joinpath(datadir, "meshview2D-2.png") viz(v, color=1:50)
  @test_reference joinpath(datadir, "meshview2D-3.png") viz(v, color=1:50, colormap="inferno")
  g = CartesianGrid(10, 10, 10)
  m = convert(SimpleMesh, g)
  v = view(m, 1:2:1000)
  @test_reference joinpath(datadir, "meshview3D-1.png") viz(v)
  @test_reference joinpath(datadir, "meshview3D-2.png") viz(v, color=1:500)
  @test_reference joinpath(datadir, "meshview3D-3.png") viz(v, color=1:500, colormap="inferno")
end

@testitem "Special values" setup = [Setup] begin
  rng = StableRNG(123)

  # missing values
  g = CartesianGrid(2, 2)
  c = [1, missing, 3, missing]
  @test_reference joinpath(datadir, "missing-values.png") viz(g, color=c)

  # NaN values
  g = CartesianGrid(2, 2)
  c = [1.0, NaN, 3.0, NaN]
  @test_reference joinpath(datadir, "nan-values.png") viz(g, color=c)

  # colors
  g = CartesianGrid(10, 10)
  c = Gray.(rand(rng, 100))
  @test_reference joinpath(datadir, "color-values.png") viz(g, color=c)

  # distributions
  g = CartesianGrid(10, 10)
  c = Normal.(rand(rng, 100), rand(rng, 100))
  @test_reference joinpath(datadir, "distribution-values.png") viz(g, color=c)
end

@testitem "TriRefinement" setup = [Setup] begin
  grid = CartesianGrid(3, 3)
  ref1 = refine(grid, TriRefinement())
  ref2 = refine(ref1, TriRefinement())
  ref3 = refine(ref2, TriRefinement())
  fig = Mke.Figure(size=(900, 300))
  viz(fig[1, 1], ref1, showsegments=true)
  viz(fig[1, 2], ref2, showsegments=true)
  viz(fig[1, 3], ref3, showsegments=true)
  @test_reference joinpath(datadir, "trirefinement.png") fig
end

@testitem "QuadRefinement" setup = [Setup] begin
  points = Point.([(0, 0), (1, 0), (0, 1), (1, 1), (0.25, 0.25), (0.75, 0.25), (0.5, 0.75)])
  connec = connect.([(1, 2, 6, 5), (1, 5, 7, 3), (2, 4, 7, 6), (3, 7, 4)])
  mesh = SimpleMesh(points, connec)
  ref1 = refine(mesh, QuadRefinement())
  ref2 = refine(ref1, QuadRefinement())
  ref3 = refine(ref2, QuadRefinement())
  fig = Mke.Figure(size=(900, 300))
  viz(fig[1, 1], ref1, showsegments=true)
  viz(fig[1, 2], ref2, showsegments=true)
  viz(fig[1, 3], ref3, showsegments=true)
  @test_reference joinpath(datadir, "quadrefinement.png") fig
end

@testitem "CatmullClark" setup = [Setup] begin
  points = Point.([(0, 0), (1, 0), (0, 1), (1, 1), (0.5, 0.5)])
  connec = connect.([(1, 2, 5), (2, 4, 5), (4, 3, 5), (3, 1, 5)])
  mesh = SimpleMesh(points, connec)
  ref1 = refine(mesh, CatmullClarkRefinement())
  ref2 = refine(ref1, CatmullClarkRefinement())
  ref3 = refine(ref2, CatmullClarkRefinement())
  fig = Mke.Figure(size=(900, 300))
  viz(fig[1, 1], ref1, showsegments=true)
  viz(fig[1, 2], ref2, showsegments=true)
  viz(fig[1, 3], ref3, showsegments=true)
  @test_reference joinpath(datadir, "catmullclark1.png") fig

  points = Point.([(0, 0), (1, 0), (0, 1), (1, 1), (0.25, 0.25), (0.75, 0.25), (0.5, 0.75)])
  connec = connect.([(1, 2, 6, 5), (1, 5, 7, 3), (2, 4, 7, 6), (3, 7, 4)])
  mesh = SimpleMesh(points, connec)
  ref1 = refine(mesh, CatmullClarkRefinement())
  ref2 = refine(ref1, CatmullClarkRefinement())
  ref3 = refine(ref2, CatmullClarkRefinement())
  fig = Mke.Figure(size=(900, 300))
  viz(fig[1, 1], ref1, showsegments=true)
  viz(fig[1, 2], ref2, showsegments=true)
  viz(fig[1, 3], ref3, showsegments=true)
  @test_reference joinpath(datadir, "catmullclark2.png") fig

  points = Point.([(0, 0, 0), (1, 0, 0), (1, 1, 0), (0, 1, 0), (0, 0, 1), (1, 0, 1), (1, 1, 1), (0, 1, 1)])
  connec = connect.([(1, 4, 3, 2), (5, 6, 7, 8), (1, 2, 6, 5), (3, 4, 8, 7), (1, 5, 8, 4), (2, 3, 7, 6)])
  mesh = SimpleMesh(points, connec)
  ref1 = refine(mesh, CatmullClarkRefinement())
  ref2 = refine(ref1, CatmullClarkRefinement())
  ref3 = refine(ref2, CatmullClarkRefinement())
  fig = Mke.Figure(size=(900, 300))
  viz(fig[1, 1], ref1, showsegments=true)
  viz(fig[1, 2], ref2, showsegments=true)
  viz(fig[1, 3], ref3, showsegments=true)
  @test_reference joinpath(datadir, "catmullclark3.png") fig
end

@testitem "TriSubdivision" setup = [Setup] begin
  points = Point.([(-1, -1, -1), (1, 1, -1), (1, -1, 1), (-1, 1, 1)])
  connec = connect.([(1, 2, 3), (3, 2, 4), (4, 2, 1), (1, 3, 4)])
  mesh = SimpleMesh(points, connec)
  ref1 = refine(mesh, TriSubdivision())
  ref2 = refine(ref1, TriSubdivision())
  ref3 = refine(ref2, TriSubdivision())
  fig = Mke.Figure(size=(900, 300))
  viz(fig[1, 1], ref1, showsegments=true)
  viz(fig[1, 2], ref2, showsegments=true)
  viz(fig[1, 3], ref3, showsegments=true)
  @test_reference joinpath(datadir, "trisubdivision.png") fig
end
