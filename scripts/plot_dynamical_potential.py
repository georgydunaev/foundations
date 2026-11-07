#!/usr/bin/env python3
"""Plot the two spatial windows in the shear-torus counterexample.

Run from any directory with Python 3, NumPy and Matplotlib installed:
    python3 scripts/plot_dynamical_potential.py

Outputs: pictures/dynamical_potential_locality.pdf and .eps.
All curves evaluate the explicit formulas in Chapter 4; there are no
external data, fitted parameters, or numerical semigroup computations.
The figure illustrates the argument and is not numerical proof.
"""

from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


def main():
    output = Path(__file__).resolve().parents[1] / "pictures"
    output.mkdir(exist_ok=True)
    plt.rcParams.update({
        "font.family": "serif",
        "mathtext.fontset": "dejavuserif",
        "font.size": 10,
        "axes.titlesize": 11,
        "axes.labelsize": 11,
        "axes.spines.top": False,
        "axes.spines.right": False,
        "pdf.fonttype": 42,
        "ps.fonttype": 42,
        "savefig.facecolor": "white",
    })
    x = np.linspace(-4.0, 4.0, 1201)
    epsilons = (0.02, 0.005, 0.001)
    styles = (("0.35", ":"), ("#527b9c", "--"), ("#123e65", "-"))
    fig, axes = plt.subplots(1, 2, figsize=(7.0, 3.25), sharey=True)
    handles = []
    for epsilon, (color, linestyle) in zip(epsilons, styles):
        a = np.sin(2 * np.pi * epsilon)
        values = np.cos(2 * np.pi * a * x)
        line, = axes[0].plot(x, values, color=color, linestyle=linestyle,
                             linewidth=1.7, label=rf"$\varepsilon={epsilon:g}$")
        axes[1].plot(x, -values, color=color, linestyle=linestyle, linewidth=1.7)
        handles.append(line)
    for ax, limit, variable in zip(axes, (1, -1), ("g", "u")):
        ax.axhline(limit, color="black", linewidth=0.85)
        ax.axhline(0, color="0.85", linewidth=0.6, zorder=0)
        ax.set(xlim=(-4, 4), ylim=(-1.12, 1.12), xlabel=rf"${variable}$",
               xticks=(-4, -2, 0, 2, 4), yticks=(-1, 0, 1))
        ax.tick_params(direction="out", length=3)
    axes[0].set_title(r"Fixed window: $V_\varepsilon(g)$")
    axes[1].set_title(r"Translated window: $W_\varepsilon(u)$")
    axes[0].set_ylabel("Potential")
    axes[0].text(-3.8, 0.94, r"limit $+1$", fontsize=9, va="top")
    axes[1].text(-3.8, -0.94, r"limit $-1$", fontsize=9, va="bottom")
    fig.legend(handles=handles, loc="lower center", bbox_to_anchor=(0.5, 0.105),
               ncol=3, frameon=False, handlelength=3)
    fig.text(0.5, 0.025,
             r"$a_\varepsilon=\sin(2\pi\varepsilon),\quad "
             r"b_\varepsilon=(2a_\varepsilon)^{-1},\quad "
             r"W_\varepsilon(u)=V_\varepsilon(u+b_\varepsilon)$",
             ha="center", fontsize=10)
    fig.subplots_adjust(left=0.09, right=0.985, top=0.88, bottom=0.32, wspace=0.16)
    stem = output / "dynamical_potential_locality"
    fig.savefig(stem.with_suffix(".pdf"), metadata={
        "Title": "Fixed and translated windows for shear-torus potentials",
        "Creator": "scripts/plot_dynamical_potential.py (NumPy and Matplotlib)",
        "CreationDate": None,
        "ModDate": None,
    })
    fig.savefig(stem.with_suffix(".eps"))
    plt.close(fig)


if __name__ == "__main__":
    main()
