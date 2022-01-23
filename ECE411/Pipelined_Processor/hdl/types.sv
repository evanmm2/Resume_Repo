package mux_types;
typedef enum {pc_mux1, rs1_out_mux1, dont_care_mux1} alumux1_sel_t;
typedef enum {u_imm_mux2, b_imm_mux2, s_imm_mux2, i_imm_mux2, j_imm_mux2, rs2_out_mux2, dont_care_mux2} alumux2_sel_t;
typedef enum {rs2_out_cmp, i_imm_cmp, dont_care_cmp} cmpmux_sel_t;

endpackage