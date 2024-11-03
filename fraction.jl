using StaticArrays
using LinearAlgebra

# const iso_value::Float64 = 0.0;

function get_len_frac(a::T,b::T)::T where T
    if (a < 0 && b < 0) return 1.0;
    end
    if (a < 0 && 0 <= b) return a / (a - b);
    end
    if (0 <= a && b < 0) return b / (b - a);
    end

    return T(0);
end

function  get_e(N::Int64,inside::Bool,v::SVector{8, Float64})::SVector{3, Float64}

        if (inside) 
            if  (N == 0) 
                return SVector(get_len_frac(v[0+1], v[1+1]), 0.0, 0.0)
            elseif  (N == 1) 
                return SVector(1.0, get_len_frac(v[1+1], v[2+1]), 0.0);
            elseif  (N == 2) 
                return SVector(get_len_frac(v[2+1], v[3+1]), 1.0, 0.0);
            elseif  (N == 3) 
                return SVector(0.0, get_len_frac(v[0+1], v[3+1]), 0.0);
            elseif  (N == 4) 
                return SVector(get_len_frac(v[4+1], v[5+1]), 0.0, 1.0);
            elseif  (N == 5) 
                return SVector(1.0, get_len_frac(v[5+1], v[6+1]), 1.0);
            elseif  (N == 6) 
                return SVector(get_len_frac(v[6+1], v[7+1]), 1.0, 1.0);
            elseif  (N == 7)
                 return SVector(0.0, get_len_frac(v[4+1], v[7+1]), 1.0);
            elseif  (N == 8) 
                return SVector(0.0, 0.0, get_len_frac(v[0+1], v[4+1]));
            elseif  (N == 9) 
                return SVector(1.0, 0.0, get_len_frac(v[1+1], v[5+1]));
            elseif  (N == 10)
                 return SVector(1.0, 1.0, get_len_frac(v[2+1], v[6+1]));
            elseif  (N == 11) 
                return SVector(0.0, 1.0, get_len_frac(v[3+1], v[7+1]));
            end
        
        elseif (!inside) 
            if  (N == 0) 
                return SVector(1.0 - get_len_frac(v[0+1], v[1+1]), 0.0, 0.0);
            elseif  (N == 1) 
                return SVector(1.0, 1.0 - get_len_frac(v[1+1], v[2+1]), 0.0);
            elseif  (N == 2) 
                return SVector(1.0 - get_len_frac(v[2+1], v[3+1]), 1.0, 0.0);
            elseif  (N == 3) 
                return SVector(0.0, 1.0 - get_len_frac(v[0+1], v[3+1]), 0.0);
            elseif  (N == 4) 
                return SVector(1.0 - get_len_frac(v[4+1], v[5+1]), 0.0, 1.0);
            elseif  (N == 5) 
                return SVector(1.0, 1.0 - get_len_frac(v[5+1], v[6+1]), 1.0);
            elseif  (N == 6) 
                return SVector(1.0 - get_len_frac(v[6+1], v[7+1]), 1.0, 1.0);
            elseif  (N == 7) 
                return SVector(0.0, 1.0 - get_len_frac(v[4+1], v[7+1]), 1.0);
            elseif  (N == 8) 
                return SVector(0.0, 0.0, 1.0 - get_len_frac(v[0+1], v[4+1]));
            elseif  (N == 9) 
                return SVector(1.0, 0.0, 1.0 - get_len_frac(v[1+1], v[5+1]));
            elseif  (N == 10) 
                return SVector(1.0, 1.0, 1.0 - get_len_frac(v[2+1], v[6+1]));
            elseif  (N == 11) 
                return SVector(0.0, 1.0, 1.0 - get_len_frac(v[3+1], v[7+1]));
        
            end
        end

        return SVector(0.0, 0.0, 0.0)
    
end

function get_rotated_vals(N::Int64, v::SVector{8, Float64})::SVector{8, Float64}

	if  (N == 0) 
        return v;
	elseif  (N == 1) 
        return SVector{8, Float64}(v[4+1], v[5+1], v[1+1], v[0+1], v[7+1], v[6+1], v[2+1], v[3+1] );
	elseif  (N == 2) 
        return SVector{8, Float64}( v[7+1], v[6+1], v[5+1], v[4+1], v[3+1], v[2+1], v[1+1], v[0+1] );
	elseif  (N == 3) 
        return SVector{8, Float64}( v[3+1], v[2+1], v[6+1], v[7+1], v[0+1], v[1+1], v[5+1], v[4+1] );
	elseif  (N == 4)
         return SVector{8, Float64}( v[4+1], v[0+1], v[3+1], v[7+1], v[5+1], v[1+1], v[2+1], v[6+1] );
	elseif  (N == 5)
         return SVector{8, Float64}( v[5+1], v[4+1], v[7+1], v[6+1], v[1+1], v[0+1], v[3+1], v[2+1] );
	elseif  (N == 6)
         return SVector{8, Float64}( v[1+1], v[5+1], v[6+1], v[2+1], v[0+1], v[4+1], v[7+1], v[3+1] );
	elseif  (N == 7)
         return SVector{8, Float64}( v[3+1], v[0+1], v[1+1], v[2+1], v[7+1], v[4+1], v[5+1], v[6+1] );
	elseif  (N == 8)
         return SVector{8, Float64}( v[2+1], v[3+1], v[0+1], v[1+1], v[6+1], v[7+1], v[4+1], v[5+1] );
	elseif  (N == 9) 
        return SVector{8, Float64}( v[1+1], v[2+1], v[3+1], v[0+1], v[5+1], v[6+1], v[7+1], v[4+1] );
	elseif  (N == 10)
         return SVector{8, Float64}( v[0+1], v[4+1], v[5+1], v[1+1], v[3+1], v[7+1], v[6+1], v[2+1] );
	elseif  (N == 11) 
        return SVector{8, Float64}( v[0+1], v[3+1], v[7+1], v[4+1], v[1+1], v[2+1], v[6+1], v[5+1] );
	elseif  (N == 12) 
        return SVector{8, Float64}( v[2+1], v[1+1], v[5+1], v[6+1], v[3+1], v[0+1], v[4+1], v[7+1] );
	elseif  (N == 13) 
        return SVector{8, Float64}( v[5+1], v[1+1], v[0+1], v[4+1], v[6+1], v[2+1], v[3+1], v[7+1] );
	elseif  (N == 14) 
        return SVector{8, Float64}( v[5+1], v[6+1], v[2+1], v[1+1], v[4+1], v[7+1], v[3+1], v[0+1] );
	elseif  (N == 15) 
        return SVector{8, Float64}( v[7+1], v[3+1], v[2+1], v[6+1], v[4+1], v[0+1], v[1+1], v[5+1] );
	elseif  (N == 16) 
        return SVector{8, Float64}( v[2+1], v[6+1], v[7+1], v[3+1], v[1+1], v[5+1], v[4+1], v[0+1] );
	elseif  (N == 17) 
        return SVector{8, Float64}( v[7+1], v[4+1], v[0+1], v[3+1], v[6+1], v[5+1], v[1+1], v[2+1] );
	elseif  (N == 18) 
        return SVector{8, Float64}( v[1+1], v[0+1], v[4+1], v[5+1], v[2+1], v[3+1], v[7+1], v[6+1] );
	elseif  (N == 19) 
        return SVector{8, Float64}( v[3+1], v[7+1], v[4+1], v[0+1], v[2+1], v[6+1], v[5+1], v[1+1] );
	elseif  (N == 20) 
        return SVector{8, Float64}( v[6+1], v[7+1], v[3+1], v[2+1], v[5+1], v[4+1], v[0+1], v[1+1] );
	elseif  (N == 21) 
        return SVector{8, Float64}( v[6+1], v[2+1], v[1+1], v[5+1], v[7+1], v[3+1], v[0+1], v[4+1] );
	elseif  (N == 22) 
        return SVector{8, Float64}( v[4+1], v[7+1], v[6+1], v[5+1], v[0+1], v[3+1], v[2+1], v[1+1] );
	elseif  (N == 23) 
        return SVector{8, Float64}( v[6+1], v[5+1], v[4+1], v[7+1], v[2+1], v[1+1], v[0+1], v[3+1] );
    end

	return v; 
    

end

function get_mc_table_index(v::SVector{8, Float64})::Int64
    
        table_index = 0;
        if (v[0+1] < 0.0) table_index |= 1;
        end
        if (v[1+1] < 0.0) table_index |= 2;
        end
        if (v[2+1] < 0.0) table_index |= 4;
        end
        if (v[3+1] < 0.0) table_index |= 8;
        end
        if (v[4+1] < 0.0) table_index |= 16;
        end
        if (v[5+1] < 0.0) table_index |= 32;
        end
        if (v[6+1] < 0.0) table_index |= 64;
        end
        if (v[7+1] < 0.0) table_index |= 128;
        end
        return table_index;

end

function get_mc_vol_case(N::Int64,M::Int64,v::SVector{8,Float64})::Float64

        scale = 1.0 / 6.0;
        function sv(v0::SVector{3,Float64},v1::SVector{3,Float64},v2::SVector{3,Float64}) 
            return ((v1 - v0)×(v0 - v2)) ⋅ v0
        end

        function pattern1(v::SVector{4, Float64}) 
            return get_len_frac(v[0+1], v[1+1]) * get_len_frac(v[0+1], v[2+1]) * get_len_frac(v[0+1], v[3+1])
        end
        function pattern2(v::SVector{6, Float64})
            e1 = get_len_frac(v[3+1], v[4+1]);
            return ((get_len_frac(v[0+1], v[1+1]) + e1) * get_len_frac(v[1+1], v[2+1]) + (e1 * get_len_frac(v[4+1], v[5+1])));
        end
        function pattern21(v::SVector{4, Float64}) 
            return (1.0 - get_len_frac(v[0+1], v[1+1])) * (1.0 - get_len_frac(v[0+1], v[2+1])) * (1.0 - get_len_frac(v[0+1], v[3+1]));
        end
    
        if (N == 0) 
            return 0.0;
        
        elseif (N == 1) 
            return scale * pattern1(SVector(v[0+1], v[1+1], v[3+1], v[4+1]));
        
        elseif (N == 2) 
            return scale * pattern2(SVector( v[3+1], v[0+1], v[4+1], v[2+1], v[1+1], v[5+1] ));
        
        elseif (N == 3) 
            return scale * (pattern1(SVector( v[0+1], v[1+1], v[3+1], v[4+1] )) + pattern1(SVector( v[5+1], v[1+1], v[6+1], v[4+1] )));
        
        elseif (N == 4) 
            return scale * (pattern1(SVector( v[0+1], v[1+1], v[3+1], v[4+1] )) + pattern1(SVector( v[6+1], v[7+1], v[5+1], v[2+1] )));
        
        elseif (N == 5) 
            e3 = get_len_frac(v[0+1], v[3+1]);
            vol0 = get_len_frac(v[1+1], v[5+1]) * (1.0 - 0.5 * (1.0 - get_len_frac(v[0+1], v[1+1])) * (1.0 - e3)) / 3.0;
            e11 = get_len_frac(v[3+1], v[7+1]);
            return vol0 + scale * ((get_len_frac(v[2+1], v[6+1]) + e11) + e3 * e11);
        
        elseif  (N == 6) 
            return scale * (pattern2(SVector( v[3+1], v[0+1], v[4+1], v[2+1], v[1+1], v[5+1] )) + pattern1(SVector( v[6+1], v[7+1], v[5+1], v[2+1] )));
        
        elseif  (N == 7) 
            return scale * (pattern1(SVector( v[4+1], v[0+1], v[5+1], v[7+1] )) + pattern1(SVector( v[1+1], v[0+1], v[2+1], v[5+1] )) +
                pattern1(SVector( v[6+1], v[7+1], v[5+1], v[2+1] )));
        
        elseif  (N == 8) 
            return scale * (2.0 * get_len_frac(v[0+1], v[4+1]) + get_len_frac(v[1+1], v[5+1]) +
                2.0 * get_len_frac(v[2+1], v[6+1]) + get_len_frac(v[3+1], v[7+1]));
        
        elseif  (N == 9) 
             e0 = get_e(0, true,v)
             e1 = get_e(1, false,v)
             e6 = get_e(6, true,v)
             e7 = get_e(7, false,v)
             e8 = get_e(8, true,v)
             e10 = get_e(10, true,v)
             _e10 = get_len_frac(v[2+1], v[6+1]);
             _e6 = get_len_frac(v[6+1], v[7+1]);
             area = (1.0 - 0.5 * (1.0 - _e6) * (1.0 - _e10)) / 3.0 +
                scale * get_len_frac(v[1+1], v[2+1]) * _e10 +
                scale * (_e6 * get_len_frac(v[4+1], v[7+1]));

            if  (M == 0) 
                return area + scale * (sv(e10, e7, e6) + sv(e1, e7, e10) + sv(e1, e8, e7) + sv(e1, e0, e8));
            
            elseif  (M == 1) 
                return area + scale * (sv(e10, e1, e0) + sv(e6, e10, e0) + sv(e6, e0, e8) + sv(e6, e8, e7));
            end
        
        elseif  (N == 10) 
            return scale * (pattern2(SVector( v[4+1], v[7+1], v[6+1], v[0+1], v[3+1], v[2+1] )) + pattern2(SVector( v[2+1], v[1+1], v[0+1], v[6+1], v[5+1], v[4+1] )));
        
        elseif  (N == 11) 
            e0 = get_e(0, true,v)
            e1 = get_e(1, false,v)
            e5 = get_e(5, false,v)
            e6 = get_e(6, false,v)
            e8 = get_e(8, true,v)
            e11 = get_e(11, true,v)
            _e5 = get_len_frac(v[5+1], v[6+1]);
            _e6 = get_len_frac(v[6+1], v[7+1]);
            area = scale * (get_len_frac(v[1+1], v[2+1]) + _e5) +
                (1.0 - 0.5 * (1.0 - _e6) * (1.0 - get_len_frac(v[3+1], v[7+1]))) / 3.0 +
                scale * (_e5 * _e6);
            return area + scale * (sv(e0, e8, e11) + sv(e0, e11, e5) + sv(e0, e5, e1) + sv(e5, e11, e6));
        
        elseif (N == 12) 
            e0 = get_len_frac(v[0+1], v[1+1]);
            e9 = get_len_frac(v[1+1], v[5+1]);
            return get_len_frac(v[3+1], v[7+1]) * (1.0 - 0.5 * (1.0 - e0) * (1.0 - get_len_frac(v[0+1], v[3+1]))) / 3.0 +
                scale * ((e9 + get_len_frac(v[2+1], v[6+1])) + e0 * e9 + pattern1(SVector( v[4+1], v[0+1], v[5+1], v[7+1] )));
        
        elseif  (N == 13) 
            return scale * (pattern1(SVector( v[4+1], v[0+1], v[5+1], v[7+1] )) + pattern1(SVector( v[1+1], v[0+1], v[2+1], v[5+1] )) +
                pattern1(SVector( v[6+1], v[7+1], v[5+1], v[2+1] )) + pattern1(SVector( v[3+1], v[0+1], v[2+1], v[7+1] )));
        
        elseif  (N == 14) 
            e0 = get_e(0,false,v)
            e3 = get_e(3, false,v)
            e6 = get_e(6, true,v)
            e7 = get_e(7, false,v)
            e9 = get_e(9, true,v)
            e10 = get_e(10, true,v)
            _e10 = get_len_frac(v[2+1], v[6+1]);
            _e6 = get_len_frac(v[6+1], v[7+1]);
            area = scale * (get_len_frac(v[1+1], v[5+1]) + _e10) +
                scale * (_e6 * get_len_frac(v[4+1], v[7+1])) +
                (1.0 - 0.5 * (1.0 - _e6) * (1.0 - _e10)) / 3.0;
            return area + scale * (sv(e0, e3, e7) + sv(e0, e7, e10) + sv(e0, e10, e9) + sv(e6, e10, e7));
        
        elseif  (N == 15) 
            e0 = get_e(0, true,v)
            e1 = get_e(1, false,v)
            e6 = get_e(6, true,v)
            e7 = get_e(7, false,v)
            e8 = get_e(8, true,v)
            e10 = get_e(10, true,v);
            _e10 = get_len_frac(v[2+1], v[6+1]);
            _e6 = get_len_frac(v[6+1], v[7+1]);
            return (1.0 - 0.5 * (1.0 - _e6) * (1.0 - _e10)) / 3.0 +
                scale * get_len_frac(v[1+1], v[2+1]) * _e10 +
                scale * (_e6 * get_len_frac(v[4+1], v[7+1])) +
                scale * (sv(e1, e6, e10) + sv(e1, e7, e6) + sv(e1, e0, e7) + sv(e8, e7, e0)) +
                scale * pattern1(SVector( v[5+1], v[4+1], v[1+1], v[6+1] ));
        
        elseif  (N == 16) 
            e1 = get_e(1, false,v)
            e3 = get_e(3, false,v)
            e5 = get_e(5, true,v)
            e6 = get_e(6, true,v)
            e8 = get_e(8, false,v)
            e9 = get_e(9, false,v)
            e10 = get_e(10, true,v)
            _e10 = get_len_frac(v[2+1], v[6+1]);
            _e5 = get_len_frac(v[5+1], v[6+1]);
            _e6 = get_len_frac(v[6+1], v[7+1]);
            return scale * (sv(e1, e3, e6) + sv(e1, e6, e10) + sv(e3, e8, e6) + sv(e5, e6, e9) + sv(e8, e9, e6)) +
                scale * (get_len_frac(v[1+1], v[2+1]) * _e10 + _e5 * get_len_frac(v[1+1], v[5+1])) +
                (1.0 - 0.5 * (1.0 - _e6) * (1.0 - _e10)) / 3.0 +
                (1.0 - 0.5 * (1.0 - _e6) * (1.0 - _e5)) / 3.0;
        
        elseif  (N == 17) 
            e3 = get_len_frac(v[0+1], v[3+1]);
            e11 = get_len_frac(v[3+1], v[7+1]);
            return 1.0 - ((1.0 - get_len_frac(v[1+1], v[5+1])) * (1.0 - 0.5 * get_len_frac(v[0+1], v[1+1]) * e3) / 3.0 +
                scale * ((1.0 - get_len_frac(v[2+1], v[6+1])) + (1.0 - e11) + (1.0 - e3) * (1.0 - e11)));
        
        elseif  (N == 18) 
            return 1.0 - scale * (pattern21(SVector( v[0+1], v[1+1], v[3+1], v[4+1] )) + pattern21(SVector( v[6+1], v[5+1], v[2+1], v[7+1] )));
        
        elseif  (N == 19) 
            e0 = get_e(0, false,v)
            e3 = get_e(3, false,v)
            e4 = get_e(4, true,v)
            e5 = get_e(5, false,v)
            e8 = get_e(8, false,v)
            e9 = get_e(9, true,v)
            _e5 = get_len_frac(v[5+1], v[6+1]);
            return 1.0 - (scale * (-sv(e8, e4, e5) - sv(e8, e5, e3) - sv(e9, e0, e5) - sv(e0, e3, e5)) +
                (0.5 * (1.0 - get_len_frac(v[1+1], v[5+1])) * (1.0 - _e5)) / 3.0 +
                (0.5 * (1.0 - _e5) * (1.0 - get_len_frac(v[4+1], v[5+1]))) / 3.0);
        
        elseif  (N == 20) 
            e1 = get_len_frac(v[1+1], v[2+1]);
            return 1.0 - scale * (((1.0 - get_len_frac(v[0+1], v[3+1])) +
                (1.0 - e1)) * (1.0 - get_len_frac(v[0+1], v[4+1])) +
                (1.0 - e1) * (1.0 - get_len_frac(v[1+1], v[5+1])));
        
        elseif  (N == 21) 
            return 1.0 - scale * pattern21(SVector( v[0+1], v[1+1], v[3+1], v[4+1] ));
        
        elseif  (N == 22) 
            return 1.0;
        
        end

        return 0.0

        

end

function get_mc_vol(v::SVector{8,Float64})
    table_index =  get_mc_table_index(v)
    if table_index == 0
        return get_mc_vol_case(0, 0, get_rotated_vals(0,v))
    elseif table_index == 1
        return get_mc_vol_case(1, 0, get_rotated_vals(0,v))
    elseif table_index == 2
        return get_mc_vol_case(1, 0, get_rotated_vals(6,v))
    elseif table_index == 3
        return get_mc_vol_case(2, 0, get_rotated_vals(0,v))
    elseif table_index == 4
        return get_mc_vol_case(1, 0, get_rotated_vals(8,v))
    elseif table_index == 5
        return get_mc_vol_case(3, 0, get_rotated_vals(12,v))
    elseif table_index == 6
        return get_mc_vol_case(2, 0, get_rotated_vals(12,v))
    elseif table_index == 7
        return get_mc_vol_case(5, 0, get_rotated_vals(7,v))
    elseif table_index == 8
        return get_mc_vol_case(1, 0, get_rotated_vals(3,v))
    elseif table_index == 9
        return get_mc_vol_case(2, 0, get_rotated_vals(7,v))
    elseif table_index == 10
        return get_mc_vol_case(3, 0, get_rotated_vals(3,v))
    elseif table_index == 11
        return get_mc_vol_case(5, 0, get_rotated_vals(8,v))
    elseif table_index == 12
        return get_mc_vol_case(2, 0, get_rotated_vals(8,v))
    elseif table_index == 13
        return get_mc_vol_case(5, 0, get_rotated_vals(9,v))
    elseif table_index == 14
        return get_mc_vol_case(5, 0, get_rotated_vals(0,v))
    elseif table_index == 15
        return get_mc_vol_case(8, 0, get_rotated_vals(0,v))
    elseif table_index == 16
        return get_mc_vol_case(1, 0, get_rotated_vals(1,v))
    elseif table_index == 17
        return get_mc_vol_case(2, 0, get_rotated_vals(10,v))
    elseif table_index == 18
        return get_mc_vol_case(3, 0, get_rotated_vals(4,v))
    elseif table_index == 19
        return get_mc_vol_case(5, 0, get_rotated_vals(13,v))
    elseif table_index == 20
        return get_mc_vol_case(4, 0, get_rotated_vals(8,v))
    elseif table_index == 21
        return get_mc_vol_case(6, 0, get_rotated_vals(4,v))
    elseif table_index == 22
        return get_mc_vol_case(6, 0, get_rotated_vals(12,v))
    elseif table_index == 23
        return get_mc_vol_case(11, 0, get_rotated_vals(8,v))
    elseif table_index == 24
        return get_mc_vol_case(3, 0, get_rotated_vals(7,v))
    elseif table_index == 25
        return get_mc_vol_case(5, 0, get_rotated_vals(17,v))
    elseif table_index == 26
        return get_mc_vol_case(7, 0, get_rotated_vals(12,v))
    elseif table_index == 27
        return get_mc_vol_case(9, 1, get_rotated_vals(19,v))
    elseif table_index == 28
        return get_mc_vol_case(6, 0, get_rotated_vals(8,v))
    elseif table_index == 29
        return get_mc_vol_case(14, 1, get_rotated_vals(9,v))
    elseif table_index == 30
        return get_mc_vol_case(12, 0, get_rotated_vals(0,v))
    elseif table_index == 31
        return get_mc_vol_case(17, 0, get_rotated_vals(22,v))
    elseif table_index == 32
        return get_mc_vol_case(1, 0, get_rotated_vals(5,v))
    elseif table_index == 33
        return get_mc_vol_case(3, 0, get_rotated_vals(0,v))
    elseif table_index == 34
        return get_mc_vol_case(2, 0, get_rotated_vals(13,v))
    elseif table_index == 35
        return get_mc_vol_case(5, 0, get_rotated_vals(1,v))
    elseif table_index == 36
        return get_mc_vol_case(3, 0, get_rotated_vals(13,v))
    elseif table_index == 37
        return get_mc_vol_case(7, 0, get_rotated_vals(4,v))
    elseif table_index == 38
        return get_mc_vol_case(5, 0, get_rotated_vals(21,v))
    elseif table_index == 39
        return get_mc_vol_case(9, 1, get_rotated_vals(14,v))
    elseif table_index == 40
        return get_mc_vol_case(4, 0, get_rotated_vals(5,v))
    elseif table_index == 41
        return get_mc_vol_case(6, 0, get_rotated_vals(7,v))
    elseif table_index == 42
        return get_mc_vol_case(6, 0, get_rotated_vals(13,v))
    elseif table_index == 43
        return get_mc_vol_case(14, 0, get_rotated_vals(8,v))
    elseif table_index == 44
        return get_mc_vol_case(6, 0, get_rotated_vals(3,v))
    elseif table_index == 45
        return get_mc_vol_case(12, 1, get_rotated_vals(9,v))
    elseif table_index == 46
        return get_mc_vol_case(11, 0, get_rotated_vals(14,v))
    elseif table_index == 47
        return get_mc_vol_case(17, 0, get_rotated_vals(5,v))
    elseif table_index == 48
        return get_mc_vol_case(2, 0, get_rotated_vals(1,v))
    elseif table_index == 49
        return get_mc_vol_case(5, 0, get_rotated_vals(18,v))
    elseif table_index == 50
        return get_mc_vol_case(5, 0, get_rotated_vals(10,v))
    elseif table_index == 51
        return get_mc_vol_case(8, 0, get_rotated_vals(13,v))
    elseif table_index == 52
        return get_mc_vol_case(6, 0, get_rotated_vals(1,v))
    elseif table_index == 53
        return get_mc_vol_case(12, 1, get_rotated_vals(18,v))
    elseif table_index == 54
        return get_mc_vol_case(14, 0, get_rotated_vals(10,v))
    elseif table_index == 55
        return get_mc_vol_case(17, 0, get_rotated_vals(16,v))
    elseif table_index == 56
        return get_mc_vol_case(6, 0, get_rotated_vals(5,v))
    elseif table_index == 57
        return get_mc_vol_case(11, 0, get_rotated_vals(13,v))
    elseif table_index == 58
        return get_mc_vol_case(12, 1, get_rotated_vals(10,v))
    elseif table_index == 59
        return get_mc_vol_case(17, 0, get_rotated_vals(3,v))
    elseif table_index == 60
        return get_mc_vol_case(10, 0, get_rotated_vals(21,v))
    elseif table_index == 61
        return get_mc_vol_case(16, 0, get_rotated_vals(2,v))
    elseif table_index == 62
        return get_mc_vol_case(16, 0, get_rotated_vals(20,v))
    elseif table_index == 63
        return get_mc_vol_case(20, 0, get_rotated_vals(20,v))
    elseif table_index == 64
        return get_mc_vol_case(1, 0, get_rotated_vals(20,v))
    elseif table_index == 65
        return get_mc_vol_case(4, 0, get_rotated_vals(0,v))
    elseif table_index == 66
        return get_mc_vol_case(3, 0, get_rotated_vals(23,v))
    elseif table_index == 67
        return get_mc_vol_case(6, 0, get_rotated_vals(0,v))
    elseif table_index == 68
        return get_mc_vol_case(2, 0, get_rotated_vals(21,v))
    elseif table_index == 69
        return get_mc_vol_case(6, 0, get_rotated_vals(21,v))
    elseif table_index == 70
        return get_mc_vol_case(5, 0, get_rotated_vals(14,v))
    elseif table_index == 71
        return get_mc_vol_case(14, 0, get_rotated_vals(14,v))
    elseif table_index == 72
        return get_mc_vol_case(3, 0, get_rotated_vals(21,v))
    elseif table_index == 73
        return get_mc_vol_case(6, 0, get_rotated_vals(11,v))
    elseif table_index == 74
        return get_mc_vol_case(7, 0, get_rotated_vals(13,v))
    elseif table_index == 75
        return get_mc_vol_case(12, 1, get_rotated_vals(8,v))
    elseif table_index == 76
        return get_mc_vol_case(5, 0, get_rotated_vals(15,v))
    elseif table_index == 77
        return get_mc_vol_case(11, 0, get_rotated_vals(0,v))
    elseif table_index == 78
        return get_mc_vol_case(9, 1, get_rotated_vals(20,v))
    elseif table_index == 79
        return get_mc_vol_case(17, 0, get_rotated_vals(23,v))
    elseif table_index == 80
        return get_mc_vol_case(3, 0, get_rotated_vals(1,v))
    elseif table_index == 81
        return get_mc_vol_case(6, 0, get_rotated_vals(10,v))
    elseif table_index == 82
        return get_mc_vol_case(7, 0, get_rotated_vals(0,v))
    elseif table_index == 83
        return get_mc_vol_case(12, 0, get_rotated_vals(13,v))
    elseif table_index == 84
        return get_mc_vol_case(6, 0, get_rotated_vals(16,v))
    elseif table_index == 85
        return get_mc_vol_case(10, 0, get_rotated_vals(7,v))
    elseif table_index == 86
        return get_mc_vol_case(12, 1, get_rotated_vals(14,v))
    elseif table_index == 87
        return get_mc_vol_case(16, 0, get_rotated_vals(19,v))
    elseif table_index == 88
        return get_mc_vol_case(7, 0, get_rotated_vals(8,v))
    elseif table_index == 89
        return get_mc_vol_case(12, 0, get_rotated_vals(17,v))
    elseif table_index == 90
        return get_mc_vol_case(13, 0, get_rotated_vals(0,v))
    elseif table_index == 91
        return get_mc_vol_case(15, 0, get_rotated_vals(1,v))
    elseif table_index == 92
        return get_mc_vol_case(12, 0, get_rotated_vals(15,v))
    elseif table_index == 93
        return get_mc_vol_case(16, 0, get_rotated_vals(6,v))
    elseif table_index == 94
        return get_mc_vol_case(15, 0, get_rotated_vals(7,v))
    elseif table_index == 95
        return get_mc_vol_case(19, 0, get_rotated_vals(17,v))
    elseif table_index == 96
        return get_mc_vol_case(2, 0, get_rotated_vals(14,v))
    elseif table_index == 97
        return get_mc_vol_case(6, 0, get_rotated_vals(23,v))
    elseif table_index == 98
        return get_mc_vol_case(5, 0, get_rotated_vals(12,v))
    elseif table_index == 99
        return get_mc_vol_case(11, 0, get_rotated_vals(10,v))
    elseif table_index == 100
        return get_mc_vol_case(5, 0, get_rotated_vals(6,v))
    elseif table_index == 101
        return get_mc_vol_case(12, 1, get_rotated_vals(6,v))
    elseif table_index == 102
        return get_mc_vol_case(8, 0, get_rotated_vals(12,v))
    elseif table_index == 103
        return get_mc_vol_case(17, 0, get_rotated_vals(11,v))
    elseif table_index == 104
        return get_mc_vol_case(6, 0, get_rotated_vals(14,v))
    elseif table_index == 105
        return get_mc_vol_case(10, 0, get_rotated_vals(1,v))
    elseif table_index == 106
        return get_mc_vol_case(12, 0, get_rotated_vals(12,v))
    elseif table_index == 107
        return get_mc_vol_case(16, 0, get_rotated_vals(22,v))
    elseif table_index == 108
        return get_mc_vol_case(14, 1, get_rotated_vals(6,v))
    elseif table_index == 109
        return get_mc_vol_case(16, 0, get_rotated_vals(17,v))
    elseif table_index == 110
        return get_mc_vol_case(17, 0, get_rotated_vals(19,v))
    elseif table_index == 111
        return get_mc_vol_case(20, 0, get_rotated_vals(22,v))
    elseif table_index == 112
        return get_mc_vol_case(5, 0, get_rotated_vals(2,v))
    elseif table_index == 113
        return get_mc_vol_case(14, 1, get_rotated_vals(18,v))
    elseif table_index == 114
        return get_mc_vol_case(9, 1, get_rotated_vals(22,v))
    elseif table_index == 115
        return get_mc_vol_case(17, 0, get_rotated_vals(20,v))
    elseif table_index == 116
        return get_mc_vol_case(11, 0, get_rotated_vals(12,v))
    elseif table_index == 117
        return get_mc_vol_case(16, 0, get_rotated_vals(15,v))
    elseif table_index == 118
        return get_mc_vol_case(17, 0, get_rotated_vals(4,v))
    elseif table_index == 119
        return get_mc_vol_case(20, 0, get_rotated_vals(19,v))
    elseif table_index == 120
        return get_mc_vol_case(12, 0, get_rotated_vals(2,v))
    elseif table_index == 121
        return get_mc_vol_case(16, 0, get_rotated_vals(9,v))
    elseif table_index == 122
        return get_mc_vol_case(15, 0, get_rotated_vals(21,v))
    elseif table_index == 123
        return get_mc_vol_case(19, 0, get_rotated_vals(2,v))
    elseif table_index == 124
        return get_mc_vol_case(16, 0, get_rotated_vals(18,v))
    elseif table_index == 125
        return get_mc_vol_case(18, 0, get_rotated_vals(6,v))
    elseif table_index == 126
        return get_mc_vol_case(19, 0, get_rotated_vals(15,v))
    elseif table_index == 127
        return get_mc_vol_case(21, 0, get_rotated_vals(2,v))
    elseif table_index == 128
        return get_mc_vol_case(1, 0, get_rotated_vals(2,v))
    elseif table_index == 129
        return get_mc_vol_case(3, 0, get_rotated_vals(15,v))
    elseif table_index == 130
        return get_mc_vol_case(4, 0, get_rotated_vals(6,v))
    elseif table_index == 131
        return get_mc_vol_case(6, 0, get_rotated_vals(18,v))
    elseif table_index == 132
        return get_mc_vol_case(3, 0, get_rotated_vals(2,v))
    elseif table_index == 133
        return get_mc_vol_case(7, 0, get_rotated_vals(21,v))
    elseif table_index == 134
        return get_mc_vol_case(6, 0, get_rotated_vals(9,v))
    elseif table_index == 135
        return get_mc_vol_case(12, 1, get_rotated_vals(7,v))
    elseif table_index == 136
        return get_mc_vol_case(2, 0, get_rotated_vals(19,v))
    elseif table_index == 137
        return get_mc_vol_case(5, 0, get_rotated_vals(4,v))
    elseif table_index == 138
        return get_mc_vol_case(6, 0, get_rotated_vals(15,v))
    elseif table_index == 139
        return get_mc_vol_case(11, 1, get_rotated_vals(9,v))
    elseif table_index == 140
        return get_mc_vol_case(5, 0, get_rotated_vals(20,v))
    elseif table_index == 141
        return get_mc_vol_case(9, 0, get_rotated_vals(0,v))
    elseif table_index == 142
        return get_mc_vol_case(14, 0, get_rotated_vals(0,v))
    elseif table_index == 143
        return get_mc_vol_case(17, 0, get_rotated_vals(2,v))
    elseif table_index == 144
        return get_mc_vol_case(2, 0, get_rotated_vals(22,v))
    elseif table_index == 145
        return get_mc_vol_case(5, 0, get_rotated_vals(19,v))
    elseif table_index == 146
        return get_mc_vol_case(6, 0, get_rotated_vals(17,v))
    elseif table_index == 147
        return get_mc_vol_case(14, 0, get_rotated_vals(13,v))
    elseif table_index == 148
        return get_mc_vol_case(6, 0, get_rotated_vals(22,v))
    elseif table_index == 149
        return get_mc_vol_case(12, 1, get_rotated_vals(19,v))
    elseif table_index == 150
        return get_mc_vol_case(10, 0, get_rotated_vals(13,v))
    elseif table_index == 151
        return get_mc_vol_case(16, 0, get_rotated_vals(14,v))
    elseif table_index == 152
        return get_mc_vol_case(5, 0, get_rotated_vals(11,v))
    elseif table_index == 153
        return get_mc_vol_case(8, 0, get_rotated_vals(4,v))
    elseif table_index == 154
        return get_mc_vol_case(12, 0, get_rotated_vals(11,v))
    elseif table_index == 155
        return get_mc_vol_case(17, 0, get_rotated_vals(6,v))
    elseif table_index == 156
        return get_mc_vol_case(11, 1, get_rotated_vals(4,v))
    elseif table_index == 157
        return get_mc_vol_case(17, 0, get_rotated_vals(12,v))
    elseif table_index == 158
        return get_mc_vol_case(16, 0, get_rotated_vals(23,v))
    elseif table_index == 159
        return get_mc_vol_case(20, 0, get_rotated_vals(14,v))
    elseif table_index == 160
        return get_mc_vol_case(3, 0, get_rotated_vals(17,v))
    elseif table_index == 161
        return get_mc_vol_case(7, 0, get_rotated_vals(7,v))
    elseif table_index == 162
        return get_mc_vol_case(6, 0, get_rotated_vals(6,v))
    elseif table_index == 163
        return get_mc_vol_case(12, 1, get_rotated_vals(1,v))
    elseif table_index == 164
        return get_mc_vol_case(7, 0, get_rotated_vals(1,v))
    elseif table_index == 165
        return get_mc_vol_case(13, 0, get_rotated_vals(19,v))
    elseif table_index == 166
        return get_mc_vol_case(12, 1, get_rotated_vals(21,v))
    elseif table_index == 167
        return get_mc_vol_case(15, 0, get_rotated_vals(8,v))
    elseif table_index == 168
        return get_mc_vol_case(6, 0, get_rotated_vals(19,v))
    elseif table_index == 169
        return get_mc_vol_case(12, 0, get_rotated_vals(4,v))
    elseif table_index == 170
        return get_mc_vol_case(10, 0, get_rotated_vals(0,v))
    elseif table_index == 171
        return get_mc_vol_case(16, 0, get_rotated_vals(16,v))
    elseif table_index == 172
        return get_mc_vol_case(12, 1, get_rotated_vals(20,v))
    elseif table_index == 173
        return get_mc_vol_case(15, 0, get_rotated_vals(0,v))
    elseif table_index == 174
        return get_mc_vol_case(16, 0, get_rotated_vals(10,v))
    elseif table_index == 175
        return get_mc_vol_case(19, 0, get_rotated_vals(1,v))
    elseif table_index == 176
        return get_mc_vol_case(5, 0, get_rotated_vals(23,v))
    elseif table_index == 177
        return get_mc_vol_case(9, 0, get_rotated_vals(13,v))
    elseif table_index == 178
        return get_mc_vol_case(11, 1, get_rotated_vals(18,v))
    elseif table_index == 179
        return get_mc_vol_case(17, 0, get_rotated_vals(15,v))
    elseif table_index == 180
        return get_mc_vol_case(12, 0, get_rotated_vals(23,v))
    elseif table_index == 181
        return get_mc_vol_case(15, 0, get_rotated_vals(13,v))
    elseif table_index == 182
        return get_mc_vol_case(16, 0, get_rotated_vals(11,v))
    elseif table_index == 183
        return get_mc_vol_case(19, 0, get_rotated_vals(21,v))
    elseif table_index == 184
        return get_mc_vol_case(14, 1, get_rotated_vals(23,v))
    elseif table_index == 185
        return get_mc_vol_case(17, 0, get_rotated_vals(14,v))
    elseif table_index == 186
        return get_mc_vol_case(16, 0, get_rotated_vals(21,v))
    elseif table_index == 187
        return get_mc_vol_case(20, 0, get_rotated_vals(21,v))
    elseif table_index == 188
        return get_mc_vol_case(16, 0, get_rotated_vals(0,v))
    elseif table_index == 189
        return get_mc_vol_case(19, 0, get_rotated_vals(23,v))
    elseif table_index == 190
        return get_mc_vol_case(18, 0, get_rotated_vals(0,v))
    elseif table_index == 191
        return get_mc_vol_case(21, 0, get_rotated_vals(20,v))
    elseif table_index == 192
        return get_mc_vol_case(2, 0, get_rotated_vals(20,v))
    elseif table_index == 193
        return get_mc_vol_case(6, 0, get_rotated_vals(20,v))
    elseif table_index == 194
        return get_mc_vol_case(6, 0, get_rotated_vals(2,v))
    elseif table_index == 195
        return get_mc_vol_case(10, 0, get_rotated_vals(12,v))
    elseif table_index == 196
        return get_mc_vol_case(5, 0, get_rotated_vals(3,v))
    elseif table_index == 197
        return get_mc_vol_case(12, 0, get_rotated_vals(3,v))
    elseif table_index == 198
        return get_mc_vol_case(11, 1, get_rotated_vals(6,v))
    elseif table_index == 199
        return get_mc_vol_case(16, 0, get_rotated_vals(5,v))
    elseif table_index == 200
        return get_mc_vol_case(5, 0, get_rotated_vals(16,v))
    elseif table_index == 201
        return get_mc_vol_case(14, 1, get_rotated_vals(4,v))
    elseif table_index == 202
        return get_mc_vol_case(12, 0, get_rotated_vals(16,v))
    elseif table_index == 203
        return get_mc_vol_case(16, 0, get_rotated_vals(1,v))
    elseif table_index == 204
        return get_mc_vol_case(8, 0, get_rotated_vals(3,v))
    elseif table_index == 205
        return get_mc_vol_case(17, 0, get_rotated_vals(10,v))
    elseif table_index == 206
        return get_mc_vol_case(17, 0, get_rotated_vals(18,v))
    elseif table_index == 207
        return get_mc_vol_case(20, 0, get_rotated_vals(1,v))
    elseif table_index == 208
        return get_mc_vol_case(5, 0, get_rotated_vals(5,v))
    elseif table_index == 209
        return get_mc_vol_case(11, 1, get_rotated_vals(23,v))
    elseif table_index == 210
        return get_mc_vol_case(12, 0, get_rotated_vals(5,v))
    elseif table_index == 211
        return get_mc_vol_case(16, 0, get_rotated_vals(3,v))
    elseif table_index == 212
        return get_mc_vol_case(14, 1, get_rotated_vals(3,v))
    elseif table_index == 213
        return get_mc_vol_case(16, 0, get_rotated_vals(13,v))
    elseif table_index == 214
        return get_mc_vol_case(16, 0, get_rotated_vals(7,v))
    elseif table_index == 215
        return get_mc_vol_case(18, 0, get_rotated_vals(5,v))
    elseif table_index == 216
        return get_mc_vol_case(9, 0, get_rotated_vals(4,v))
    elseif table_index == 217
        return get_mc_vol_case(17, 0, get_rotated_vals(21,v))
    elseif table_index == 218
        return get_mc_vol_case(15, 0, get_rotated_vals(4,v))
    elseif table_index == 219
        return get_mc_vol_case(19, 0, get_rotated_vals(13,v))
    elseif table_index == 220
        return get_mc_vol_case(17, 0, get_rotated_vals(1,v))
    elseif table_index == 221
        return get_mc_vol_case(20, 0, get_rotated_vals(13,v))
    elseif table_index == 222
        return get_mc_vol_case(19, 0, get_rotated_vals(0,v))
    elseif table_index == 223
        return get_mc_vol_case(21, 0, get_rotated_vals(5,v))
    elseif table_index == 224
        return get_mc_vol_case(5, 0, get_rotated_vals(22,v))
    elseif table_index == 225
        return get_mc_vol_case(12, 1, get_rotated_vals(22,v))
    elseif table_index == 226
        return get_mc_vol_case(14, 0, get_rotated_vals(12,v))
    elseif table_index == 227
        return get_mc_vol_case(16, 0, get_rotated_vals(8,v))
    elseif table_index == 228
        return get_mc_vol_case(9, 0, get_rotated_vals(12,v))
    elseif table_index == 229
        return get_mc_vol_case(15, 0, get_rotated_vals(12,v))
    elseif table_index == 230
        return get_mc_vol_case(17, 0, get_rotated_vals(17,v))
    elseif table_index == 231
        return get_mc_vol_case(19, 0, get_rotated_vals(7,v))
    elseif table_index == 232
        return get_mc_vol_case(11, 1, get_rotated_vals(3,v))
    elseif table_index == 233
        return get_mc_vol_case(16, 0, get_rotated_vals(12,v))
    elseif table_index == 234
        return get_mc_vol_case(16, 0, get_rotated_vals(4,v))
    elseif table_index == 235
        return get_mc_vol_case(18, 0, get_rotated_vals(8,v))
    elseif table_index == 236
        return get_mc_vol_case(17, 0, get_rotated_vals(13,v))
    elseif table_index == 237
        return get_mc_vol_case(19, 0, get_rotated_vals(4,v))
    elseif table_index == 238
        return get_mc_vol_case(20, 0, get_rotated_vals(10,v))
    elseif table_index == 239
        return get_mc_vol_case(21, 0, get_rotated_vals(1,v))
    elseif table_index == 240
        return get_mc_vol_case(8, 0, get_rotated_vals(23,v))
    elseif table_index == 241
        return get_mc_vol_case(17, 0, get_rotated_vals(0,v))
    elseif table_index == 242
        return get_mc_vol_case(17, 0, get_rotated_vals(9,v))
    elseif table_index == 243
        return get_mc_vol_case(20, 0, get_rotated_vals(8,v))
    elseif table_index == 244
        return get_mc_vol_case(17, 0, get_rotated_vals(8,v))
    elseif table_index == 245
        return get_mc_vol_case(19, 0, get_rotated_vals(3,v))
    elseif table_index == 246
        return get_mc_vol_case(20, 0, get_rotated_vals(7,v))
    elseif table_index == 247
        return get_mc_vol_case(21, 0, get_rotated_vals(3,v))
    elseif table_index == 248
        return get_mc_vol_case(17, 0, get_rotated_vals(7,v))
    elseif table_index == 249
        return get_mc_vol_case(20, 0, get_rotated_vals(12,v))
    elseif table_index == 250
        return get_mc_vol_case(19, 0, get_rotated_vals(12,v))
    elseif table_index == 251
        return get_mc_vol_case(21, 0, get_rotated_vals(8,v))
    elseif table_index == 252
        return get_mc_vol_case(20, 0, get_rotated_vals(0,v))
    elseif table_index == 253
        return get_mc_vol_case(21, 0, get_rotated_vals(6,v))
    elseif table_index == 254
        return get_mc_vol_case(21, 0, get_rotated_vals(0,v))
    elseif table_index == 255
        return get_mc_vol_case(22, 0, get_rotated_vals(0,v))
    end
    return 0.0

end
